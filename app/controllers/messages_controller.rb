class MessagesController < ApplicationController

  def index
    @messages = current_user.mailbox.inbox
    @box_title = "Inbox"
  end

  def show
    conversation = Mailboxer::Conversation.find(params[:id])
    conversation.mark_as_read(current_user)
    @messages = conversation.messages.reverse
  end

  def im_interested
    listing = Listing.find(params[:id])
    Inquiry.create(listing_id: listing.id, user_id: current_user.id, offer: params[:offer])
    current_user.send_message(listing.user, message_body, message_subject(listing))
    redirect_to listing
  end

  def reply
    conversation = Mailboxer::Conversation.find(params[:id])
    current_user.reply_to_conversation(conversation, params[:reply][:body])
    redirect_to message_path(conversation)
    # @reply = conversation.messages.reverse.last
    # respond_to do |format|
    #   format.js
    # end
  end

  def sent_box
    @messages = current_user.mailbox.sentbox
    @box_title = "Sent"
    respond_to do |format|
      format.html { render :index }
    end
  end

  def trash_box
    @messages = current_user.mailbox.trash
    @box_title = "Trash"
    respond_to do |format|
      format.html { render :index }
    end
  end

  private

  def message_body
    params[:body] || "Please let me know if it's still for sale!"
  end

  def message_subject(listing)
    params[:subject] || "#{current_user.full_name} is interested in your #{listing.headline}!"
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