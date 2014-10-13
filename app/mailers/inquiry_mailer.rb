class InquiryMailer < ActionMailer::Base
  default from: "no-reply@bonsai-list.com"

  def new_inquiry_email(inquiry)
    @listing = inquiry.listing
    @user = inquiry.user
    mail(to: @user.email, subject: "You have a new offer on #{@listing.headline} | Bonsai List")
  end
end
