require "test_helper"

class ChatHumanRequestsControllerTest < ActionDispatch::IntegrationTest
  test "returns not found when no conversation in session" do
    post chat_human_requests_path, as: :turbo_stream
    assert_response :not_found
  end

  test "marks conversation as wanting human and renders turbo stream" do
    conversation = ChatConversation.create!(session_id: "test", last_activity_at: Time.current)
    conversation.chat_messages.create!(role: "user", content: "Hello")

    # First, set the session by posting a chat message
    post chat_messages_path, params: { content: "Hi there" }, as: :turbo_stream
    assert_response :success

    # Now click "Talk to a human"
    post chat_human_requests_path, as: :turbo_stream
    assert_response :success

    # Verify the conversation was updated
    conversation_id = session[:chat_conversation_id]
    updated_conversation = ChatConversation.find(conversation_id)
    assert updated_conversation.wants_human
  end

  test "returns 406 when requested as HTML (no turbo_stream template)" do
    post chat_messages_path, params: { content: "Hi there" }, as: :turbo_stream
    assert_response :success

    post chat_human_requests_path
    assert_response :not_acceptable
  end
end
