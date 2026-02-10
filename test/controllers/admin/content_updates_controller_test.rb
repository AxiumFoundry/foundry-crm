require "test_helper"

class Admin::ContentUpdatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    post session_path, params: { email: users(:admin).email, password: "password123" }
  end

  test "requires authentication" do
    delete session_path
    patch admin_content_update_path, params: { key: "nav_logo", value: "New Logo" }, as: :json
    assert_redirected_to root_path
  end

  test "updates valid content key" do
    patch admin_content_update_path, params: { key: "nav_logo", value: "New Logo" }, as: :json
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal "nav_logo", json["key"]
    assert_equal "New Logo", json["value"]
  end

  test "rejects invalid content key" do
    patch admin_content_update_path, params: { key: "nonexistent_key", value: "anything" }, as: :json
    assert_response :unprocessable_entity
    json = JSON.parse(response.body)
    assert_equal "Invalid content key", json["error"]
  end

  test "persists value in database" do
    patch admin_content_update_path, params: { key: "home_hero_heading", value: "Build faster." }, as: :json
    assert_response :success
    assert_equal "Build faster.", SiteSetting.current.text("home_hero_heading")
  end

  test "reset removes custom value and returns default" do
    setting = SiteSetting.current
    setting.update!(content: (setting.content || {}).merge("nav_logo" => "Custom Logo"))
    assert_equal "Custom Logo", setting.text("nav_logo")

    patch admin_content_update_path, params: { key: "nav_logo", reset: true }, as: :json
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal "Foundry CRM", json["value"]
    assert_equal "Foundry CRM", SiteSetting.current.reload.text("nav_logo")
  end
end
