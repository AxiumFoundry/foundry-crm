class CaseStudy < ApplicationRecord
  extend FriendlyId
  friendly_id :client_name, use: :slugged

  scope :published, -> { where(published: true) }
  scope :featured, -> { where(featured: true) }
  scope :ordered, -> { order(position: :asc) }

  validates :client_name, presence: true
  validates :challenge_summary, presence: true, length: { maximum: 200 }
  validates :website_url, format: { with: /\Ahttps?:\/\/\S+\z/, message: "must be a valid http:// or https:// URL" }, allow_blank: true

  def metrics_display
    metrics&.map { |k, v| "#{k}: #{v}" }&.join(", ")
  end
end
