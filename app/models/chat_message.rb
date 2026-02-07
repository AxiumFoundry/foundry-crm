class ChatMessage < ApplicationRecord
  belongs_to :chat_conversation

  validates :role, presence: true, inclusion: { in: %w[user assistant] }
  validates :content, presence: true

  scope :ordered, -> { order(created_at: :asc) }

  after_create_commit :broadcast_assistant_response, if: :assistant?

  def assistant?
    role == "assistant"
  end

  private

  def broadcast_assistant_response
    broadcast_render_to(
      chat_conversation,
      partial: "chat_messages/assistant_broadcast",
      locals: { message: self }
    )
  end
end
