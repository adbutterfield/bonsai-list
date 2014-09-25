module MessagesHelper
  #TODO get rid of messages helper if it's not used
  def set_message_notice_text(conversation)
    if conversation.receipts_for(current_user).first.is_unread?
      return conversation.subject
    else
      return conversation.messages.last.body
    end
  end
end