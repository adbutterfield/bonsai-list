class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader

  acts_as_messageable

  extend FriendlyId
  friendly_id :name_and_id, use: :slugged

  has_one :address
  validates_associated :address
  has_many :listings, -> { where(remove: false) }
  has_many :posted_listings, -> { where(remove: false, publish: true) }, class_name: 'Listing'
  has_many :inquiries, dependent: :destroy

  accepts_nested_attributes_for :address, allow_destroy: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, :last_name, presence: true
  validates :email, uniqueness: { case_sensitive: false }

  before_save :set_timezone, if: :timezone_is_blank?

  def name_and_id
    "#{self.first_name}#{self.last_name}#{self.id}"
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def location
    "#{self.address.city}, #{self.address.state}"
  end

  def mailboxer_email(object)
    self.email
  end

  def new_messages_count
    self.mailbox.inbox(unread: true).length
  end

  def new_offers_count
    # TODO optimize a query to grab this stuff
    self.new_offers.map { |listing| listing.inquiries.not_seen.count }.inject(&:+).to_i
  end

  def not_already_inquired?(listing)
    self.inquiries.where(listing_id: listing.id).empty?
  end

  def new_offers
    Listing.joins(:inquiries).where(user_id: self.id).where('inquiries.is_seen = false').group('listings.id').having('COUNT(inquiries.id) > 0').order(created_at: :desc)
  end

  def seen_offers
    Listing.joins(:inquiries).where(user_id: self.id).where('inquiries.is_seen = true').group('listings.id').having('COUNT(inquiries.id) > 0').order(created_at: :desc)
  end

  def sent_offers
    Listing.includes(:inquiries).where("inquiries.user_id = ?", self.id).references(:inquiries)
  end

  def filter_listings_by(params)
    params[:sort] ||= "created_at desc"

    if params[:category_id].present?
      category = Category.friendly.find(params[:category_id])
      return self.posted_listings.where(category_id: category.id).order(params[:sort])
    else
      return self.posted_listings.order(params[:sort])
    end
  end

  private
    def timezone_is_blank?
      self.timezone.blank?
    end

    def set_timezone
      self.timezone = (Timezone::Zone.new :latlon => [self.address.latitude, self.address.longitude]).zone
    end
end
