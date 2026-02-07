class MarkStaleConversationsInactiveJob < ApplicationJob
  queue_as :default

  def perform
    ChatConversation.stale.find_each(&:mark_inactive!)
  end
end
