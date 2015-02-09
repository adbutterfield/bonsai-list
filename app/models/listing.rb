class Listing < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by,
                  :against => [:headline, :description],
                  :using => {
                    :tsearch => {:prefix => true}
                  }
  extend FriendlyId
  friendly_id :headline_and_id, use: :slugged

  belongs_to :user
  belongs_to :category
  has_many :inquiries, inverse_of: :listing, dependent: :destroy
  has_many :listing_images, dependent: :destroy
  accepts_nested_attributes_for :listing_images, allow_destroy: true
  validates :headline, :description, :price, :category, :user_id, :latitude, :longitude, :sale_type, :listing_images, presence: true
  validates :shippable, :publish, :remove, inclusion: { in: [true, false] }
  validates :price, numericality: true

  scope :postable, -> { where(remove: false, publish: true) }

  reverse_geocoded_by :latitude, :longitude

  def headline_and_id
    "#{self.headline} #{self.id}"
  end

  def up_to_four
    case self.listing_images.length
    when 0
      return 4
    when 1
      return 3
    when 2
      return 2
    when 3
      return 1
    when 4
      return 0
    end
  end

  def increment_view_count(current_user)
    unless current_user == self.user
      self.increment(:views)
      self.save
    end
  end

  def published?
    self.publish ? "Yes" : "No"
  end

  def set_latitude_and_longitude
    self.latitude = self.user.address.latitude
    self.longitude = self.user.address.longitude
  end

  def location
    "#{self.user.address.city}, #{self.user.address.state}"
  end

  def remove_listing
    self.update(remove: true)
  end

  def inquiry_sent_date(current_user)
    self.inquiries.first.created_at.in_time_zone(current_user.timezone).strftime('%A %b %e %l:%M %P')
  end

  def is_offer?
    self.sale_type == "offer"
  end

  def main_image
    (self.listing_images.where(id: self.main_image_id)[0] || self.listing_images.first).image.main
  end

  def marketplace_image
    (self.listing_images.where(id: self.main_image_id)[0] || self.listing_images.first).image.marketplace
  end

  def thumb_image
    (self.listing_images.where(id: self.main_image_id)[0] || self.listing_images.first).image.thumb
  end

  def new_offers
    Inquiry.where(listing_id: self.id).not_seen
  end

  def pics
    self.listing_images
  end

  def seen_offers
    Inquiry.where(listing_id: self.id).seen
  end

  def seller_name
    self.user.full_name
  end

  def seller
    self.user
  end

  def willing_to_ship?
    if self.shippable
      return "Willing to ship"
    else
      return "Not willing to ship"
    end
  end

  def self.filter_by(params, coordinates)
    params[:sort] ||= "created_at desc"
    params[:distance_filter] ||= "100000"

    if params[:category_id].present?
      category = Category.friendly.find(params[:category_id])
      return Listing.postable
        .where('category_id = ?', category.id)
        .near(coordinates, params[:distance_filter], :order => params[:sort])
    else
      return Listing.postable.near(coordinates, params[:distance_filter], :order => params[:sort])
    end
  end
end
