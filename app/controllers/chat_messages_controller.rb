class ChatMessagesController < ApplicationController
  def create
    return head :unprocessable_entity if params[:content].blank?

    @conversation = find_or_create_conversation
    @new_conversation = session[:chat_conversation_id] != @conversation.id
    session[:chat_conversation_id] = @conversation.id
    @message = @conversation.chat_messages.create!(role: "user", content: params[:content])
    @conversation.touch_activity

    GenerateAiResponseJob.perform_later(@conversation.id)
  end

  private

  def find_or_create_conversation
    if session[:chat_conversation_id]
      ChatConversation.find_by(id: session[:chat_conversation_id]) ||
        create_conversation
    else
      create_conversation
    end
  end

  def create_conversation
    sid = session.id&.to_s.presence || SecureRandom.uuid
    ChatConversation.create!(session_id: sid, last_activity_at: Time.current)
  end
end
