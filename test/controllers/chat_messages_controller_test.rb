require "test_helper"

class ChatMessagesControllerTest < ActionDispatch::IntegrationTest
  test "creates conversation and message on first message" do
    post chat_messages_path, params: { content: "Hello!" }, as: :turbo_stream
    assert_response :success

    conversation = ChatConversation.order(:created_at).last
    assert_not_nil conversation

    user_messages = conversation.chat_messages.where(role: "user")
    assert_equal 1, user_messages.count
    assert_equal "Hello!", user_messages.first.content
  end

  test "reuses conversation on subsequent messages" do
    post chat_messages_path, params: { content: "First message" }, as: :turbo_stream
    first_conversation = ChatConversation.order(:created_at).last

    post chat_messages_path, params: { content: "Second message" }, as: :turbo_stream

    second_message = ChatMessage.where(role: "user").order(:created_at).last
    assert_equal first_conversation.id, second_message.chat_conversation_id
    assert_equal 2, first_conversation.chat_messages.where(role: "user").count
  end

  test "create with honeypot filled does not create message" do
    assert_no_difference "ChatMessage.count" do
      post chat_messages_path, params: { content: "spam", website_url: "http://spam.example.com" }, as: :turbo_stream
    end
    assert_response :ok
  end

  test "updates conversation last_activity_at" do
    post chat_messages_path, params: { content: "Hello!" }, as: :turbo_stream
    conversation = ChatConversation.order(:created_at).last
    assert_in_delta Time.current, conversation.last_activity_at, 5.seconds
  end
end
