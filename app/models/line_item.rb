class LineItem < ApplicationRecord
  belongs_to :invoice

  validates :description, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :unit_price_cents, presence: true, numericality: { greater_than_or_equal_to: 0 }

  before_validation :calculate_total

  def unit_price
    unit_price_cents / 100.0
  end

  def total
    total_cents / 100.0
  end

  private

  def calculate_total
    self.total_cents = ((quantity || 0) * (unit_price_cents || 0)).round
  end
end
