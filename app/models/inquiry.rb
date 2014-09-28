class Inquiry < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing

  scope :not_seen, -> { where(is_seen: false) }
  scope :seen, -> { where(is_seen: true) }

  def conversation
    Mailboxer::Conversation.find(self.conversation_id)
  end
end
