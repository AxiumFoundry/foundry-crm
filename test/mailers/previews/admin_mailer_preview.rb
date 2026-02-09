# Preview all emails at http://localhost:3000/rails/mailers/admin_mailer
class AdminMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/admin_mailer/new_health_check_submission
  def new_health_check_submission
    AdminMailer.new_health_check_submission
  end
end
