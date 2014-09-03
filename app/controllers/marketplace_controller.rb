class MarketplaceController < ApplicationController
  before_action :set_listings, only: [:index, :ajax_sort]
  after_action :set_listings, only: [:set_location]


  def index
    @categories = Category.includes(:subcategories).order(id: :asc)
  end

  def ajax_sort
    respond_to do |format|
      format.js
    end
  end

  def set_location
    session[:coordinates] = params[:coordinates]
    head :ok
  end

  private

    def set_listings
      @listings = Listing.filter_listings(params, user_coordinates)
    end

    # def user_postcode
    #   current_user.nil? ? params[:visitor_postcode] : current_user.postcode
    # end

    def user_coordinates
      current_user.nil? ? session[:coordinates] : current_user.postcode
    end
end
