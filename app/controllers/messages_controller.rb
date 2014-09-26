class MessagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :verify_user!, only: [:show, :reply]

  def index
    @messages = current_user.mailbox.inbox
    @box_title = "Inbox"
  end

  def show
    @conversation = Mailboxer::Conversation.find(params[:id])
    @conversation.mark_as_read(current_user)
    @messages = @conversation.messages.reverse
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

  def verify_user!
    conversation = Mailboxer::Conversation.find(params[:id])

    redirect_to user_root_path, notice: "We can't find the page you're looking for..." unless conversation.participants.include?(current_user)
  end

end