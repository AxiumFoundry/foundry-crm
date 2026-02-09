class AddContactFieldsToChatConversations < ActiveRecord::Migration[8.1]
  def change
    add_column :chat_conversations, :contact_name, :string
    add_column :chat_conversations, :contact_email, :string
  end
end
