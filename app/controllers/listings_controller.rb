class ListingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing, only: [:show, :edit, :update, :destroy, :remove]
  before_action :set_location, only: :create


  # GET /listings
  # GET /listings.json
  def index
    @listings = Listing.all
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
  end

  # GET /listings/new
  def new
    @listing = current_user.listings.build
    @subcategories = Subcategory.where('category_id =?', Category.first).order(id: :asc)
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = current_user.listings.build(listing_params)
    # raise
    respond_to do |format|
      if @listing.save
        format.html { redirect_to user_root_url, notice: 'Listing was successfully created.' }
        # format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        # format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
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
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:title, :description, :price, :shippable, :publish, :location, :remove, :user_id, :category_id, :subcategory_id)
    end

    def set_location
      params[:listing][:location] = current_user.postcode
    end
end
