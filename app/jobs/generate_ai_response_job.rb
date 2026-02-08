class GenerateAiResponseJob < ApplicationJob
  queue_as :default

  def perform(conversation_id)
    conversation = ChatConversation.find(conversation_id)
    content = AiResponseGenerator.new(conversation).generate

    conversation.chat_messages.create!(role: "assistant", content: content)
  rescue StandardError => e
    conversation = ChatConversation.find_by(id: conversation_id)
    conversation&.chat_messages&.create!(
      role: "assistant",
      content: "I apologize, but I'm having trouble responding right now. Please try again or contact us at hello@axiumfoundry.com."
    )

    Rails.logger.error("GenerateAiResponseJob failed for conversation #{conversation_id}: #{e.message}")
    Honeybadger.notify(e)
  end
end
