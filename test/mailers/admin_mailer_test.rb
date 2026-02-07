require "test_helper"

class AdminMailerTest < ActionMailer::TestCase
  test "new_health_check_submission" do
    submission = health_check_submissions(:one)
    mail = AdminMailer.new_health_check_submission(submission)
    assert_equal "New Health Check Submission from #{submission.company_name}", mail.subject
    assert_equal [ "dmitry.sychev@me.com" ], mail.to
  end
end
