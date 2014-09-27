class OffersController < ApplicationController
  before_filter :authenticate_user!

  def index
    # TODO fix n+1 query for getting inquiry count
    @offer_listings = current_user.offers
  end

  def show
    @listing = Listing.find(params[:id])
    @inquiries = @listing.offers
  end
end