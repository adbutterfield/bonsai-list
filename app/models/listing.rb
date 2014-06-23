class Listing < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :subcategory
  validates :title, :description, :price, :location, :category, :subcategory, :user, presence: true
  validates :shippable, :publish, :remove, inclusion: { in: [true, false] }
  geocoded_by :location
  after_validation :geocode

  scope :postable, -> { where(remove: false) }

  def published?
    self.publish ? "Yes" : "No"
  end

  def self.filter_listings(params)
    params[:sort] ||= "created_at desc"
    if params[:category_id].present?
      if params[:subcategory_id].present?
        return Listing.postable.where('category_id = ? AND subcategory_id = ?', params[:category_id], params[:subcategory_id]).order(params[:sort])
      else
        return Listing.postable.where('category_id = ?', params[:category_id]).order(params[:sort])
      end
    else
      return Listing.postable.order(params[:sort])
    end
  end
end
