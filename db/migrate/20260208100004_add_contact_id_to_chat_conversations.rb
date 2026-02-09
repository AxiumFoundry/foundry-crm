class AddContactIdToChatConversations < ActiveRecord::Migration[8.1]
  def change
    add_reference :chat_conversations, :contact, null: true, foreign_key: true
  end
end
