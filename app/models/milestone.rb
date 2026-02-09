class Milestone < ApplicationRecord
  belongs_to :project

  validates :name, presence: true

  scope :upcoming, -> { where(completed_at: nil).where("due_date >= ?", Date.current).order(due_date: :asc) }
  scope :overdue, -> { where(completed_at: nil).where("due_date < ?", Date.current) }
  scope :completed, -> { where.not(completed_at: nil) }

  def completed?
    completed_at.present?
  end
end
