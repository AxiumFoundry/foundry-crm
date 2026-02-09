class TimeEntry < ApplicationRecord
  belongs_to :project
  belongs_to :invoice, optional: true

  validates :description, presence: true
  validates :duration_minutes, presence: true, numericality: { greater_than: 0 }
  validates :date, presence: true

  scope :billable, -> { where(billable: true) }
  scope :unbilled, -> { billable.where(invoice_id: nil) }
  scope :for_month, ->(date) { where(date: date.beginning_of_month..date.end_of_month) }

  def hours
    duration_minutes / 60.0
  end
end
