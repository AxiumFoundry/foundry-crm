require "test_helper"

class CrmInquiriesControllerTest < ActionDispatch::IntegrationTest
  test "new" do
    get new_crm_inquiry_path
    assert_response :success
  end

  test "create" do
    assert_difference "CrmInquiry.count", 1 do
      post crm_inquiries_path, params: {
        crm_inquiry: {
          company_name: "Test Corp",
          contact_name: "Test User",
          email: "test@example.com",
          phone: "555-1234",
          message: "Interested in managed hosting"
        }
      }
    end
  end

  test "create with turbo stream" do
    post crm_inquiries_path, params: {
      crm_inquiry: {
        company_name: "Test Corp",
        contact_name: "Test User",
        email: "test@example.com"
      }
    }, as: :turbo_stream

    assert_response :success
  end

  test "create with invalid params" do
    assert_no_difference "CrmInquiry.count" do
      post crm_inquiries_path, params: {
        crm_inquiry: { company_name: "", contact_name: "", email: "" }
      }
    end
    assert_response :unprocessable_entity
  end
end
