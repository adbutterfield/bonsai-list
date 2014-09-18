class MarketplaceController < ApplicationController
  before_action :set_listings, only: [:index, :ajax_sort]

  def index
    @categories = Category.order(id: :asc)
  end

  def ajax_sort
    respond_to do |format|
      format.js
    end
  end

  private

    def set_listings
      if params[:search].blank?
        @listings = Listing.filter_by(params, coordinates)
      else
        @listings = Listing.filter_by(params, coordinates).search_by(params[:search])
      end
    end

    def coordinates
      "#{location.latitude}, #{location.longitude}"
    end

end
