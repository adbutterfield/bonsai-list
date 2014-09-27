module MessagesHelper
  #TODO get rid of messages helper if it's not used
  def set_message_notice_text(conversation)
    if conversation.receipts_for(current_user).first.is_unread?
      return conversation.subject
    else
      return conversation.messages.last.body
    end
  end

  def recipient(conversation)
    conversation.participants.find { |p| p != current_user }
  end

  def no_messages
    '<p class="centered-text no-messages">No messages</p>'.html_safe
  end

  def inbox?
    controller_name == 'messages' && action_name == 'index'
  end
end