require "test_helper"

class Admin::InlineUpdatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    post session_path, params: { email: users(:admin).email, password: "password123" }
    @credential = credentials(:one)
  end

  test "requires authentication" do
    delete session_path
    patch admin_inline_update_path, params: { model: "Credential", id: @credential.id, field: "title", value: "New" }, as: :json
    assert_redirected_to root_path
  end

  test "updates allowed model field" do
    patch admin_inline_update_path, params: { model: "Credential", id: @credential.id, field: "title", value: "New Title" }, as: :json
    assert_response :success
    assert_equal "New Title", @credential.reload.title
  end

  test "rejects disallowed model" do
    patch admin_inline_update_path, params: { model: "User", id: 1, field: "email", value: "hacked" }, as: :json
    assert_response :unprocessable_entity
  end

  test "rejects disallowed field" do
    patch admin_inline_update_path, params: { model: "Credential", id: @credential.id, field: "id", value: "999" }, as: :json
    assert_response :unprocessable_entity
  end
end
