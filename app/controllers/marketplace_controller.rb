class MarketplaceController < ApplicationController
  before_action :set_listings, only: [:index, :ajax_sort]
  def index
    @categories = Category.includes(:subcategories).order(id: :asc)
  end

  def ajax_sort
    respond_to do |format|
      format.js
    end
  end

  private

    def set_listings
      @listings = Listing.filter_listings(params, user_postcode)
    end

    def user_postcode
      current_user.postcode
    end
end
