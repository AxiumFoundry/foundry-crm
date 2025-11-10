class AdminMailer < ApplicationMailer
  def new_health_check_submission(submission)
    @submission = submission

    mail(
      to: "dmitry.sychev@axiumfoundry.com",
      subject: "New Health Check Submission from #{@submission.company_name}"
    )
  end
end
