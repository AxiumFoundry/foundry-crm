require "test_helper"

class Admin::CrmInquiriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:admin)
    post session_path, params: { email: @user.email, password: "password123" }
    @inquiry = crm_inquiries(:one)
  end

  test "index" do
    get admin_crm_inquiries_path
    assert_response :success
  end

  test "show" do
    get admin_crm_inquiry_path(@inquiry)
    assert_response :success
  end
end
