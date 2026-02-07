class ChatHumanRequestsController < ApplicationController
  def create
    @conversation = ChatConversation.find_by(id: session[:chat_conversation_id])
    return head :not_found unless @conversation

    @conversation.request_human!
  end
end
