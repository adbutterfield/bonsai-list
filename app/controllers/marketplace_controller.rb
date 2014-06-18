class MarketplaceController < ApplicationController
  def index
    @listings = Listing.postable
    @categories = Category.includes(:subcategories).order(id: :asc)
  end
end
