require "test_helper"

class ChatConversationTest < ActiveSupport::TestCase
  test "requires session_id" do
    conversation = ChatConversation.new(last_activity_at: Time.current)
    assert_not conversation.valid?
    assert_includes conversation.errors[:session_id], "can't be blank"
  end

  test "defaults to active status" do
    conversation = ChatConversation.create!(session_id: "abc", last_activity_at: Time.current)
    assert_equal "active", conversation.status
  end

  test "active scope returns only active conversations" do
    assert_includes ChatConversation.active, chat_conversations(:active_conversation)
    assert_not_includes ChatConversation.active, chat_conversations(:inactive_conversation)
  end

  test "stale scope returns active conversations with old activity" do
    stale = chat_conversations(:active_conversation)
    stale.update!(last_activity_at: 2.hours.ago)

    assert_includes ChatConversation.stale, stale
  end

  test "recent scope returns conversations from last 24 hours" do
    assert_includes ChatConversation.recent, chat_conversations(:active_conversation)
  end

  test "touch_activity updates last_activity_at" do
    conversation = chat_conversations(:active_conversation)
    old_activity = conversation.last_activity_at
    travel 1.minute
    conversation.touch_activity
    assert conversation.last_activity_at > old_activity
  end

  test "mark_inactive! updates status" do
    conversation = chat_conversations(:active_conversation)
    conversation.mark_inactive!
    assert_equal "inactive", conversation.reload.status
  end

  test "request_human! sets flag" do
    conversation = chat_conversations(:active_conversation)
    conversation.request_human!
    assert conversation.reload.wants_human?
  end
end
