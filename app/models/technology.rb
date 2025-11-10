class Technology < ApplicationRecord
  scope :featured, -> { where(featured: true) }
  scope :by_category, -> { order(:category, :name) }

  validates :name, presence: true, uniqueness: true
  validates :proficiency_level, inclusion: { in: 1..5 }

  def expert?
    proficiency_level >= 4
  end
end
