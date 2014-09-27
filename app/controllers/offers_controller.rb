class OffersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :verify_user!, only: :show


  def index
    # TODO fix n+1 query for getting inquiry count
    @offer_listings = current_user.offers
  end

  def show
    @listing = Listing.find(params[:id])
    @inquiries = @listing.offers
  end

  private

  def verify_user!
    user = Listing.find(params[:id]).user if params[:id]
    redirect_to user_root_path, notice: "We can't find the page you're looking for..." unless current_user?(user)
  end
end