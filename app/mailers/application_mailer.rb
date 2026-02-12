class ApplicationMailer < ActionMailer::Base
  NOTIFICATION_EMAIL = ENV.fetch("NOTIFICATION_EMAIL")

  default from: "Foundry CRM <noreply@example.com>"
  layout "mailer"
end
