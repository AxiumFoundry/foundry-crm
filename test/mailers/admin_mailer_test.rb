require "test_helper"

class AdminMailerTest < ActionMailer::TestCase
  test "new_health_check_submission" do
    mail = AdminMailer.new_health_check_submission
    assert_equal "New health check submission", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
