require "test_helper"

class ChatMessageTest < ActiveSupport::TestCase
  test "requires role" do
    message = ChatMessage.new(chat_conversation: chat_conversations(:active_conversation), content: "hi")
    assert_not message.valid?
    assert_includes message.errors[:role], "can't be blank"
  end

  test "requires content" do
    message = ChatMessage.new(chat_conversation: chat_conversations(:active_conversation), role: "user")
    assert_not message.valid?
    assert_includes message.errors[:content], "can't be blank"
  end

  test "role must be user or assistant" do
    message = ChatMessage.new(
      chat_conversation: chat_conversations(:active_conversation),
      role: "admin",
      content: "hello"
    )
    assert_not message.valid?
    assert_includes message.errors[:role], "is not included in the list"
  end

  test "assistant? returns true for assistant messages" do
    assert chat_messages(:assistant_message).assistant?
    assert_not chat_messages(:user_message).assistant?
  end

  test "ordered scope sorts by created_at ascending" do
    conversation = chat_conversations(:active_conversation)
    messages = conversation.chat_messages.ordered
    assert_equal messages, messages.sort_by(&:created_at)
  end
end
