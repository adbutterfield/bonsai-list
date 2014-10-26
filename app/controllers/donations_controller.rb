class DonationsController < ApplicationController
  protect_from_forgery except: [:show]

  def show
    @listing = Listing.friendly.find(params[:listing_id])
  end

  def create
    @listing = Listing.friendly.find(params[:listing_id])
    @donation = current_user.donations.build(donation_params)
    if @donation.save
      flash[:notice] = "Thanks for the donation!"
      redirect_to @donation.paypal_url(donation_path(@listing))
    else
      render
    end
  end

  private
    def donation_params
      params.permit(:amount)
    end
end
