class Admin::ChatConversationsController < Admin::BaseController
  def index
    @pagy, @conversations = pagy(ChatConversation.order(created_at: :desc))
  end

  def show
    @conversation = ChatConversation.find(params[:id])
    @messages = @conversation.chat_messages.ordered
  end
end
