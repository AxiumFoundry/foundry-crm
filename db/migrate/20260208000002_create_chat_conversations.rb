class CreateChatConversations < ActiveRecord::Migration[8.1]
  def change
    create_table :chat_conversations do |t|
      t.string :session_id, null: false
      t.string :status, default: "active", null: false
      t.datetime :last_activity_at, null: false
      t.boolean :wants_human, default: false

      t.timestamps
    end

    add_index :chat_conversations, :session_id
    add_index :chat_conversations, :status
    add_index :chat_conversations, :last_activity_at
  end
end
