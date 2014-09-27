class OffersController < ApplicationController
  before_filter :authenticate_user!

  def index
    # TODO fix n+1 query for getting inquiry count
    @offer_listings = Listing.inquired_on(current_user)
  end

  def show

  end
end