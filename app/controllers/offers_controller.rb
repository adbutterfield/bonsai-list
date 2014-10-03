class OffersController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_user!, only: :show
  after_action :mark_as_seen, only: :show

  def index
    # TODO fix n+1 query for getting inquiry count
    @new_listing_offers = current_user.new_offers
    @seen_listing_offers = current_user.seen_offers
  end

  def sent
    @sent_listing_offers = current_user.sent_offers
  end

  def show
    @listing = Listing.find(params[:id])
    @new_inquiries = @listing.new_offers
    @seen_inquiries = @listing.seen_offers
  end

  private

    def verify_user!
      user = Listing.find(params[:id]).user if params[:id]
      redirect_to user_root_path, notice: "We can't find the page you're looking for..." unless current_user?(user)
    end

    def mark_as_seen
      @new_inquiries.update_all(is_seen: true)
    end
end