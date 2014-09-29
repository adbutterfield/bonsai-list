class MarketplaceController < ApplicationController
  before_action :set_listings, only: [:index, :ajax_sort]

  def index
    @category = Category.find(params[:category_id]).name if params[:category_id]
    @categories = Category.order(id: :asc)
  end

  def ajax_sort
    respond_to do |format|
      format.js
    end
  end

  def show

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
