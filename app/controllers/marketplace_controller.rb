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

  private

    def user_postcode
      current_user.postcode
    end
end
