class Listing < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :subcategory
  validates :title, :description, :price, :location, :category, :subcategory, :user, presence: true
  validates :shippable, :publish, :remove, inclusion: { in: [true, false] }
  geocoded_by :location
  after_validation :geocode

  scope :postable, -> { where(remove: false, publish: true) }

  def published?
    self.publish ? "Yes" : "No"
  end

  def self.filter_listings(params, user_postcode)
    params[:sort] ||= "created_at desc"
    params[:distance_filter] ||= "50"

    if params[:category_id].present?
      if params[:subcategory_id].present?
        return Listing.postable.where('category_id = ? AND subcategory_id = ?', params[:category_id], params[:subcategory_id]).near(user_postcode, params[:distance_filter], :order => params[:sort])
      else
        return Listing.postable.where('category_id = ?', params[:category_id]).near(user_postcode, params[:distance_filter], :order => params[:sort])
      end
    else
      return Listing.postable.near(user_postcode, params[:distance_filter], :order => params[:sort])
    end
  end
end
