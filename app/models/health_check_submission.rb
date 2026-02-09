class HealthCheckSubmission < ApplicationRecord
  belongs_to :contact, optional: true

  validates :company_name, presence: true
  validates :contact_name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  scope :pending, -> { where(status: "pending") }
  scope :scheduled, -> { where(status: "scheduled") }

  after_create :send_confirmation_email
  after_create :notify_admin
  after_create :find_or_create_contact

  private

  def send_confirmation_email
    HealthCheckMailer.confirmation(self).deliver_later
  end

  def notify_admin
    AdminMailer.new_health_check_submission(self).deliver_later
  end

  def find_or_create_contact
    names = contact_name.split(" ", 2)
    contact = Contact.find_or_create_by!(email: email) do |c|
      c.first_name = names.first
      c.last_name = names.second
      c.company_name = company_name
      c.phone = phone
      c.source = "health_check"
    end
    update_columns(contact_id: contact.id)
  end
end
