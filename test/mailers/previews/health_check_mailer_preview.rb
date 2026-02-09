# Preview all emails at http://localhost:3000/rails/mailers/health_check_mailer
class HealthCheckMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/health_check_mailer/confirmation
  def confirmation
    HealthCheckMailer.confirmation
  end
end
