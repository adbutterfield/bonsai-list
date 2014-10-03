class Listing < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by,
                  :against => [:headline, :description],
                  :using => {
                    :tsearch => {:prefix => true}
                  }

  belongs_to :user
  belongs_to :category
  has_many :inquiries, dependent: :destroy
  validates :headline, :description, :price, :category, :user_id, :latitude, :longitude, :sale_type, presence: true
  validates :shippable, :publish, :remove, inclusion: { in: [true, false] }
  validates :price, numericality: true

  scope :postable, -> { where(remove: false, publish: true) }

  reverse_geocoded_by :latitude, :longitude

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

  def inquiry_sent_date
    self.inquiries.first.created_at.strftime('%A %b %e %l:%M %P')
  end

  def is_offer?
    self.sale_type == "offer"
  end

  def new_offers
    Inquiry.where(listing_id: self.id).not_seen
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
    params[:distance_filter] ||= "5000"

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
