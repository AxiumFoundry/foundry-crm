class Admin::ChatConversationsController < ApplicationController
  before_action :require_authentication

  def index
    @conversations = ChatConversation.order(created_at: :desc)
  end

  def show
    @conversation = ChatConversation.find(params[:id])
    @messages = @conversation.chat_messages.ordered
  end
end
