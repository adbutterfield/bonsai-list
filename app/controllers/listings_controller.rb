class ListingsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_listing, only: [:show, :edit, :update, :destroy, :remove]

  def index
    @categories = Category.includes(:subcategories).order(id: :asc)
    @listings = current_user.posted_listings
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
    @listing.set_latitude_and_longitude
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
      params.require(:listing).permit(:title, :description, :price, :shippable, :publish, :latitude, :longitude, :remove, :user_id, :category_id, :subcategory_id)
    end

end
