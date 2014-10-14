class MessageMailer < ActionMailer::Base
  default from: "no-reply@bonsai-list.com"

  def new_message_email(conversation)
    @conversation = conversation
    @sender = conversation.participants.first
    @recipient = conversation.participants.last
    mail(to: @recipient.email, subject: "You received a new message | Bonsai List")
  end
end
