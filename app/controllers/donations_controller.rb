class DonationsController < ApplicationController
  def show
    @listing = Listing.friendly.find(params[:listing_id])
  end

  def create
    @listing = Listing.friendly.find(params[:listing_id])
    @donation = current_user.donations.build(donation_params)
    if @donation.save
      redirect_to @donation.paypal_url(donation_path(@listing))
      flash[:notice] = "Thanks for the donation!"
    else
      render
    end
  end

  protect_from_forgery except: [:hook]
  def hook
    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    if status == "Completed"
      @donation = Donation.find params[:invoice]
      @donation.update_attributes notification_params: params, status: status, transaction_id: params[:txn_id], purchased_at: Time.now
    end
    render nothing: true
  end

  private
    def donation_params
      params.permit(:amount)
    end
end