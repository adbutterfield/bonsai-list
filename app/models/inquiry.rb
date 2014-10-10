class Inquiry < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing, inverse_of: :inquiries

  scope :not_seen, -> { where(is_seen: false) }
  scope :seen, -> { where(is_seen: true) }

  def conversation
    Mailboxer::Conversation.find(self.conversation_id)
  end

  def sent_time(current_user)
    self.created_at.in_time_zone(current_user.timezone).strftime('%A %b %e %l:%M %P')
  end
end
