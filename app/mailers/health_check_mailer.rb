class HealthCheckMailer < ApplicationMailer
  def confirmation(submission)
    @submission = submission

    mail(
      to: @submission.email,
      subject: "Thank you for requesting a NYC Startup Health Check"
    )
  end
end
