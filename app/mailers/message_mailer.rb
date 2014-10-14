class MessageMailer < ActionMailer::Base
  default from: "no-reply@bonsai-list.com"

  def new_message_email(conversation, sender, recipient)
    @conversation = conversation
    @sender = sender
    @recipient = recipient
    mail(to: @recipient.email, subject: "You received a new message | Bonsai List")
  end
end
