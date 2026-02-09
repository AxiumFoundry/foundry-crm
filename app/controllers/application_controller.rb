class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  helper_method :current_user, :logged_in?, :current_chat_conversation, :current_settings

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def current_chat_conversation
    return unless session[:chat_conversation_id]

    @current_chat_conversation ||= ChatConversation.find_by(id: session[:chat_conversation_id])
  end

  def current_settings
    @current_settings ||= SiteSetting.current
  end

  def require_authentication
    redirect_to root_path unless logged_in?
  end
end
