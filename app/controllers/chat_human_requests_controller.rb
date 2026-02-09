class ChatHumanRequestsController < ApplicationController
  def create
    @conversation = ChatConversation.find_by(id: session[:chat_conversation_id])
    return head :not_found unless @conversation

    @conversation.request_human!(
      contact_name: params[:contact_name],
      contact_email: params[:contact_email]
    )
  end
end
