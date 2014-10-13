class InquiriesController < ApplicationController
  before_action :authenticate_user!

  def create
    listing = Listing.find(params[:id])
    current_user.send_message(listing.user, message_body, message_subject(listing))
    conversation = Mailboxer::Conversation.last
    inquiry = Inquiry.create(listing_id: listing.id, user_id: current_user.id, offer: params[:offer], conversation_id: conversation.id)
    InquiryMailer.new_inquiry_email(inquiry).deliver
    redirect_to listing
  end

  private

    def message_body
      params[:body] || "Please let me know if it's still for sale!"
    end

    def message_subject(listing)
      if listing.is_offer?
        return "#{current_user.full_name} made an offer on your #{listing.headline}!"
      else
        return "#{current_user.full_name} is interested in your #{listing.headline}!"
      end
    end

end