require "test_helper"

class Admin::ChatConversationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    post session_path, params: { email: users(:admin).email, password: "password123" }
  end

  test "requires authentication for index" do
    delete session_path
    get admin_chat_conversations_path
    assert_redirected_to root_path
  end

  test "requires authentication for show" do
    delete session_path
    get admin_chat_conversation_path(chat_conversations(:active_conversation))
    assert_redirected_to root_path
  end

  test "index lists conversations" do
    get admin_chat_conversations_path
    assert_response :success
  end

  test "show displays conversation with messages" do
    get admin_chat_conversation_path(chat_conversations(:active_conversation))
    assert_response :success
  end
end
