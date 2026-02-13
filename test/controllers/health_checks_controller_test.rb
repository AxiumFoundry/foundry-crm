require "test_helper"

class HealthChecksControllerTest < ActionDispatch::IntegrationTest
  test "create with honeypot filled does not create record" do
    assert_no_difference "HealthCheckSubmission.count" do
      post health_checks_path, params: {
        health_check_submission: {
          company_name: "Spam Corp",
          contact_name: "Spammer",
          email: "spam@example.com",
          website_url: "http://spam.example.com"
        }
      }, as: :turbo_stream
    end
    assert_response :success
  end
end
