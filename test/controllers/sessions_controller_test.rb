require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get login page" do
    get login_path
    assert_response :success
  end

  test "should login with valid credentials" do
    post session_path, params: { email: users(:admin).email, password: "password123" }
    assert_redirected_to root_path
    assert_equal users(:admin).id, session[:user_id]
  end

  test "should not login with invalid password" do
    post session_path, params: { email: users(:admin).email, password: "wrong" }
    assert_response :unprocessable_entity
    assert_nil session[:user_id]
  end

  test "should not login with invalid email" do
    post session_path, params: { email: "nobody@example.com", password: "password123" }
    assert_response :unprocessable_entity
    assert_nil session[:user_id]
  end

  test "should logout" do
    post session_path, params: { email: users(:admin).email, password: "password123" }
    delete session_path
    assert_redirected_to root_path
    assert_nil session[:user_id]
  end

  test "should show admin bar when logged in" do
    post session_path, params: { email: users(:admin).email, password: "password123" }
    get root_path
    assert_select "span", text: "Admin"
  end

  test "should not show admin bar when not logged in" do
    get root_path
    assert_select "span", text: "Admin", count: 0
  end
end
