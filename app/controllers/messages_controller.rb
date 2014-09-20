class MessagesController < ApplicationController

  def index
    @new_messages = current_user.mailbox.inbox
  end

  def show
    @conversation = Mailboxer::Conversation.find(params[:id]).messages.reverse
  end

  def im_interested
    listing = Listing.find(params[:id])
    current_user.send_message(listing.user, message_body, message_subject(listing))
    redirect_to listing
  end

  # **** this is the conversation ****
  # gets the last conversation (chronologically, the first in the inbox)
  # current_user.mailbox.inbox(unread: true).first

  # here is how you get the subject
  # current_user.mailbox.inbox(unread: true).first.subject

  # **** this is the message, the collection of receipts ****
  # current_user.mailbox.inbox(unread: true).first.messages

  # get the sender
  # current_user.mailbox.inbox(unread: true).first.messages.first.sender

  # here's how you check whether the receipt is unread for the current_user
  # current_user.mailbox.inbox(unread: true).first.messages.first.is_unread? current_user

  # **** this is the collection of receipts for a particular user
  # gets receipts chronologically ordered
  # current_user.mailbox.inbox(unread: true).first.receipts_for(current_user)

  # get the sender of the receipt
  # current_user.mailbox.inbox(unread: true).first.receipts_for(current_user).first.sender

  # check if a receipt is unread
  # current_user.mailbox.inbox(unread: true).first.receipts_for(current_user).first.is_unread?

end