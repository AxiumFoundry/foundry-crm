class Project < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  STATUSES = %w[proposed active paused completed cancelled].freeze

  belongs_to :contact
  has_many :milestones, -> { order(position: :asc) }, dependent: :destroy
  has_many :time_entries, dependent: :destroy
  has_many :invoices, dependent: :nullify

  validates :name, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }

  scope :active, -> { where(status: "active") }
  scope :by_status, ->(status) { where(status: status) }
end
