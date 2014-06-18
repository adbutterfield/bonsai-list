class Listing < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :subcategory
  validates :title, :description, :price, :location, :category, :subcategory, :user, presence: true
  validates :shippable, :publish, :remove, inclusion: { in: [true, false] }

  scope :postable, -> { where(remove: false) }

  def published?
    self.publish ? "Yes" : "No"
  end

  def self.filter_listings(params)
    if params.has_key? 'category_id'
      if params.has_key? 'subcategory_id'
        return Listing.postable.where('category_id = ? AND subcategory_id = ?', params[:category_id], params[:subcategory_id])
      else
        return Listing.postable.where('category_id = ?', params[:category_id])
      end
    else
      return Listing.postable
    end
  end
end
