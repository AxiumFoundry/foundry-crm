class ChatHumanRequestsController < ApplicationController
  def create
    @conversation = ChatConversation.find(session[:chat_conversation_id])
    @conversation.request_human!
  end
end
