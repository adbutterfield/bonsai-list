class User < ActiveRecord::Base
  acts_as_messageable

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
  validates :firstname, :lastname, presence: true
  validates :email, uniqueness: { case_sensitive: false }

  def full_name
    "#{self.firstname} #{self.lastname}"
  end

  def mailboxer_email(object)
    self.email
  end

  def not_already_inquired?(listing)
    self.inquiries.where(listing_id: listing.id).empty?
  end
end
