class MarketplaceController < ApplicationController
  before_action :set_listings, only: [:ajax_sort, :show]
  before_action :set_listings, only: :index, :unless => :no_coordinates?
  before_action :set_categories, only: [:index, :show]
  before_action :set_category, only: [:index, :show]

  def index
    @listings ||= []
  end

  def ajax_sort
    respond_to do |format|
      format.js
    end
  end

  def show
  end

  def set_location
    session[:coordinates] = params[:coordinates]
    head :ok
  end

  private

    def no_coordinates?
      current_user.nil? and session[:coordinates].nil?
    end

    def set_listings
      if params[:id]
        @user = User.friendly.find(params[:id])
        if params[:search].blank?
          @listings = @user.filter_listings_by(params)
        else
          @listings = @user.filter_listings_by(params).search_by(params[:search])
        end
      else
        if params[:search].blank?
          @listings = Listing.filter_by(params, coordinates)
        else
          @listings = Listing.filter_by(params, coordinates).search_by(params[:search])
        end
      end
    end

    def coordinates
      location = current_user.nil? ? visitor_location : current_user.address
      "#{location.latitude}, #{location.longitude}"
    end

    def set_categories
      @categories = Category.order(id: :asc)
    end

    def set_category
      @category = Category.friendly.find(params[:category_id]).name if params[:category_id]
    end
end
