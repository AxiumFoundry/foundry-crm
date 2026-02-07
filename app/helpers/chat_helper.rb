module ChatHelper
  def current_chat_conversation
    return unless session[:chat_conversation_id]

    @current_chat_conversation ||= ChatConversation.find_by(id: session[:chat_conversation_id])
  end
end
