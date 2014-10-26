class DonationNotificationsController < ApplicationController
  protect_from_forgery :except => [:create] #Otherwise the request from PayPal wouldn't make it to the controller

  def create
    response = validate_IPN_notification(request.raw_post)
    case response
    when "VERIFIED"
      # check that paymentStatus=Completed
      # check that txnId has not been previously processed
      # check that receiverEmail is your Primary PayPal email
      # check that paymentAmount/paymentCurrency are correct
      # process payment

      params.permit! # Permit all Paypal input params
      status = params[:payment_status]
      if status == "Completed"
        @donation = Donation.find params[:invoice]
        @donation.update_attributes notification_params: params, status: status, transaction_id: params[:txn_id], donated_at: Time.now
      end
      # head :ok
    when "INVALID"
      # log for investigation
    else
      # error
    end
    render :nothing => true
  end

  protected
  def validate_IPN_notification(raw)
    uri = URI.parse("#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?cmd=_notify-validate")
    http = Net::HTTP.new(uri.host, uri.port)
    http.open_timeout = 60
    http.read_timeout = 60
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.use_ssl = true
    response = http.post(uri.request_uri, raw, 'Content-Length' => "#{raw.size}", 'User-Agent' => "My custom user agent").body
  end
end