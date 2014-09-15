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
      @listings = Listing.filter_listings(params, coordinates)
    end

    def coordinates
      "#{location.latitude}, #{location.longitude}"
    end

end
