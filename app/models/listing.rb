class Listing < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by,
                  :against => [:title, :description],
                  :using => {
                    :tsearch => {:prefix => true}
                  }

  belongs_to :user
  belongs_to :category
  belongs_to :subcategory
  validates :title, :description, :price, :category, :subcategory, :user_id, :latitude, :longitude, presence: true
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

  def self.filter_by(params, coordinates)
    params[:sort] ||= "created_at desc"
    params[:distance_filter] ||= "5000"

    if params[:category_id].present?
      if params[:subcategory_id].present?
        return Listing.postable
          .where('category_id = ? AND subcategory_id = ?', params[:category_id], params[:subcategory_id])
          .near(coordinates, params[:distance_filter], :order => params[:sort])
      else
        return Listing.postable
          .where('category_id = ?', params[:category_id])
          .near(coordinates, params[:distance_filter], :order => params[:sort])
      end
    else
      return Listing.postable.near(coordinates, params[:distance_filter], :order => params[:sort])
    end
  end
end
