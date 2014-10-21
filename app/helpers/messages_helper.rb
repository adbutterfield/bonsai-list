module MessagesHelper

  def avatar_pic(conversation)
    if sent_box?
      if recipient(conversation).avatar.present?
        return link_to image_tag(recipient(conversation).avatar.thumb), user_marketplace_path(recipient(conversation))
      else
        return link_to image_tag("http://placehold.it/50x50&text=[img]"), user_marketplace_path(recipient(conversation))
      end
    else
      if conversation.messages.last.sender.avatar.present?
        return link_to image_tag(conversation.messages.last.sender.avatar.thumb), user_marketplace_path(conversation.messages.last.sender)
      else
        return link_to image_tag("http://placehold.it/50x50&text=[img]"), user_marketplace_path(conversation.messages.last.sender)
      end
    end
  end

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

  def sent_box?
    controller_name == 'messages' && action_name == 'sent_box'
  end

  def trash_box?
    controller_name == 'messages' && action_name == 'trash_box'
  end

  def not_trash?
    controller_name == 'messages' && action_name != 'trash_box'
  end

  def message_subject_class(conversation)
    if conversation.is_unread?(current_user)
      return "unread-message"
    else
      return "read-message"
    end
  end
end