class Invoice < ApplicationRecord
  KINDS = %w[estimate invoice].freeze
  STATUSES = %w[draft sent viewed paid overdue void].freeze

  belongs_to :contact
  belongs_to :project, optional: true
  has_many :line_items, dependent: :destroy
  has_many :time_entries, dependent: :nullify

  accepts_nested_attributes_for :line_items, allow_destroy: true, reject_if: :all_blank

  validates :number, presence: true, uniqueness: true
  validates :kind, presence: true, inclusion: { in: KINDS }
  validates :status, presence: true, inclusion: { in: STATUSES }

  before_save :recalculate_totals

  scope :invoices, -> { where(kind: "invoice") }
  scope :estimates, -> { where(kind: "estimate") }
  scope :outstanding, -> { where(status: %w[sent viewed overdue]) }
  scope :paid, -> { where(status: "paid") }
  scope :draft, -> { where(status: "draft") }

  def self.generate_number
    setting = SiteSetting.current
    number = "#{setting.invoice_prefix}-#{setting.invoice_next_number}"
    setting.increment!(:invoice_next_number)
    number
  end

  def subtotal
    subtotal_cents / 100.0
  end

  def tax
    tax_cents / 100.0
  end

  def total
    total_cents / 100.0
  end

  private

  def recalculate_totals
    self.subtotal_cents = line_items.reject(&:marked_for_destruction?).sum(&:total_cents)
    self.tax_cents = (subtotal_cents * (tax_rate || 0) / 100).round
    self.total_cents = subtotal_cents + tax_cents
  end
end
