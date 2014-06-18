class MarketplaceController < ApplicationController
  def index
    set_listings
    @categories = Category.includes(:subcategories).order(id: :asc)
  end

  def filter_listings
    if params[:category_id] or params[:subcategory_id]
      @listings = Listing.postable.where('category_id = ? OR subcategory_id = ?', params[:category_id], params[:subcategory_id])
    else
      set_listings
    end
  end

  private

    def set_listings
      @listings = Listing.postable
    end
end
