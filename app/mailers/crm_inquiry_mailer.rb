class CrmInquiryMailer < ApplicationMailer
  def confirmation(inquiry)
    @inquiry = inquiry

    mail(
      to: @inquiry.email,
      subject: "Thank you for your interest in Foundry CRM"
    )
  end

  def admin_notification(inquiry)
    @inquiry = inquiry

    mail(
      to: "dmitry.sychev@me.com",
      subject: "New CRM Inquiry from #{@inquiry.company_name}"
    )
  end
end
