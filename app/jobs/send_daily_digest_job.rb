class SendDailyDigestJob < ApplicationJob
  queue_as :default

  def perform
    conversations = ChatConversation.recent
    return if conversations.empty?

    ChatMailer.daily_digest(conversations).deliver_now
  end
end
