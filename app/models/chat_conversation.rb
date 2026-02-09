class ChatConversation < ApplicationRecord
  belongs_to :contact, optional: true
  has_many :chat_messages, dependent: :destroy

  validates :session_id, presence: true

  scope :active, -> { where(status: "active") }
  scope :stale, -> { active.where(last_activity_at: ...1.hour.ago) }
  scope :recent, -> { where(created_at: 24.hours.ago..) }

  def touch_activity
    update!(last_activity_at: Time.current)
  end

  def mark_inactive!
    update!(status: "inactive")
    ChatMailer.conversation_transcript(self).deliver_later
  end

  def request_human!(contact_name:, contact_email:)
    update!(wants_human: true, contact_name: contact_name, contact_email: contact_email)
    link_contact(contact_name, contact_email)
    ChatMailer.human_contact_requested(self).deliver_later
  end

  private

  def link_contact(name, email)
    return if contact_id.present? || email.blank?

    names = name.to_s.split(" ", 2)
    found = Contact.find_or_create_by!(email: email) do |c|
      c.first_name = names.first.presence || "Unknown"
      c.last_name = names.second
      c.source = "chat"
    end
    update_columns(contact_id: found.id)
  end
end
