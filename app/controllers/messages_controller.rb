class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_user!, only: [:show, :reply, :trash]

  def index
    @messages = current_user.mailbox.inbox(unread: true)
    @read_messages = current_user.mailbox.inbox(unread: false)
    @box_title = "Inbox"
  end

  def show
    @conversation = Mailboxer::Conversation.find(params[:id])
    @conversation.mark_as_read(current_user)
    @messages = @conversation.messages.reverse
  end

  def reply
    conversation = Mailboxer::Conversation.find(params[:id])
    current_user.reply_to_conversation(conversation, params[:reply][:body])
    redirect_to message_path(conversation)
  end

  def trash
    conversation = Mailboxer::Conversation.find(params[:id])
    conversation.move_to_trash(current_user)
    redirect_to messages_path
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

  def verify_user!
    conversation = Mailboxer::Conversation.find(params[:id])

    redirect_to user_root_path, notice: "We can't find the page you're looking for..." unless conversation.participants.include?(current_user)
  end

end