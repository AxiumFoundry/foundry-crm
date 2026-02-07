class HealthCheckSubmission < ApplicationRecord
  validates :company_name, presence: true
  validates :contact_name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  scope :pending, -> { where(status: "pending") }
  scope :scheduled, -> { where(status: "scheduled") }

  after_create :send_confirmation_email
  after_create :notify_admin

  private

  def send_confirmation_email
    HealthCheckMailer.confirmation(self).deliver_later
  end

  def notify_admin
    AdminMailer.new_health_check_submission(self).deliver_later
  end
end
