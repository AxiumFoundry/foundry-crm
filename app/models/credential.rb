class Credential < ApplicationRecord
  scope :featured, -> { where(featured: true) }
  scope :ordered, -> { order(position: :asc) }

  validates :title, presence: true
end
