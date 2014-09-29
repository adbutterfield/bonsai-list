class ListingsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :verify_user!, only: [:edit, :update, :destroy, :remove]
  before_action :set_listing, only: [:show, :edit, :update, :destroy, :remove]
  before_action :set_categories, only: [:index, :new, :edit]
  before_action :set_listings, only: [:index, :ajax_sort]

  def index
  end

  def ajax_sort
    respond_to do |format|
      format.js
    end
  end

  def show
    @title = @listing.headline
    if current_user
      @message_body = "Please let me know if it's still for sale!"
    end
  end

  def new
    @listing = current_user.listings.build
    Struct.new("SaleType", :id, :name)
    @sale_types = [ Struct::SaleType.new(id: 'sale', name: 'Sell now?'), Struct::SaleType.new(id: 'offer', name: 'Take offers?') ]
  end

  def edit
  end

  def create
    @listing = current_user.listings.build(listing_params)
    @listing.set_latitude_and_longitude
    if params[:listing][:publish] == '1'
      @listing.published_at = Time.now
    end
    if @listing.save
      redirect_to user_root_url, notice: 'Listing was successfully created.'
    else
      @categories = Category.all
      render :new
    end
  end

  def update
    if params[:listing][:publish] == '1' && @listing.published_at.nil?
      params[:listing][:published_at] = Time.now
    end
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    if @listing.remove_listing
      redirect_to user_root_url, notice: 'Listing was successfully removed.'
    else
      redirect_to :back
    end
  end

  def remove
    if @listing.remove_listing
      redirect_to user_root_url, notice: 'Listing was successfully removed.'
    else
      redirect_to :back
    end
  end

  private
    def set_listing
      @listing = Listing.find(params[:id])
    end

    def set_listings
      if params[:sort].blank?
        @listings = current_user.filter_listings_by(params)
      else
        @listings = current_user.filter_listings_by(params).search_by(params[:search])
      end
    end

    def listing_params
      params.require(:listing).permit(:headline, :description, :price, :shippable, :publish, :latitude, :longitude, :remove, :user_id, :category_id, :sale_type, :published_at)
    end

    def verify_user!
      user = Listing.find(params[:id]).user if params[:id]
      redirect_to user_root_path, notice: "We can't find the page you're looking for..." unless current_user?(user)
    end

    def set_categories
      @categories = Category.order(id: :asc)
    end

end
