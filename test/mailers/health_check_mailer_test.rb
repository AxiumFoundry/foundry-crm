require "test_helper"

class HealthCheckMailerTest < ActionMailer::TestCase
  test "confirmation" do
    submission = health_check_submissions(:one)
    mail = HealthCheckMailer.confirmation(submission)
    assert_equal "Thank you for requesting a NYC Startup Health Check", mail.subject
    assert_equal [ submission.email ], mail.to
  end
end
