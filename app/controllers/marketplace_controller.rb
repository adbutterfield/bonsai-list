class MarketplaceController < ApplicationController
  def index
    @categories = Category.includes(:subcategories).order(id: :asc)
    @listings = Listing.filter_listings(params, user_postcode)
  end

  def ajax_sort
    @listings = Listing.filter_listings(params, user_postcode)
    respond_to do |format|
      format.js
    end
  end

  # For Ajax implementation of category filter for listings
  # def filter_listings
  #   if params[:category_id] or params[:subcategory_id]
  #     @listings = Listing.postable.where('category_id = ? OR subcategory_id = ?', params[:category_id], params[:subcategory_id])
  #   else
  #     set_listings
  #   end
  # end

  private

    def user_postcode
      current_user.postcode
    end
    # def set_listings
    #   @listings = Listing.postable
    # end
end