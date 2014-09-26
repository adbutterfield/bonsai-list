class Inquiry < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing

  def conversation
    Mailboxer::Conversation.find(self.conversation_id)
  end
end
