class AddConversationIdToInquiry < ActiveRecord::Migration
  def change
    add_reference :inquiries, :conversation, index: true
  end
end
