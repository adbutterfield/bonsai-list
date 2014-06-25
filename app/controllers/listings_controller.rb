class ListingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing, only: [:show, :edit, :update, :destroy, :remove]
  before_action :set_location, only: :create

  def index
    @categories = Category.includes(:subcategories).order(id: :asc)
    # TODO don't filter by distance on this query
    @listings = Listing.filter_listings(params, "")
  end

  def show
  end

  def new
    @listing = current_user.listings.build
    @categories = Category.all
    @subcategories = Subcategory.where('category_id = ?', Category.first).order(id: :asc)
  end

  def edit
    @categories = Category.all
    @subcategories = Subcategory.where(category_id: @listing.category_id).order(id: :asc)
  end

  def create
    @listing = current_user.listings.build(listing_params)
    respond_to do |format|
      if @listing.save
        format.html { redirect_to user_root_url, notice: 'Listing was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
    end
  end

  def remove
    @listing.update(remove: true)
    redirect_to user_root_url, notice: 'Listing was successfully removed.'
  end

  def set_subcategories
    @subcategories = Subcategory.where("category_id = ?", params[:category_id]).order(id: :asc)
    respond_to do |format|
      format.js
    end
  end

  private
    def set_listing
      @listing = Listing.find(params[:id])
    end

    def listing_params
      params.require(:listing).permit(:title, :description, :price, :shippable, :publish, :location, :remove, :user_id, :category_id, :subcategory_id)
    end

    def set_location
      params[:listing][:location] = current_user.postcode
    end
end
