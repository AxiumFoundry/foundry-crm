class Contact < ApplicationRecord
  STAGES = %w[lead prospect client inactive].freeze
  SOURCES = %w[health_check chat referral website manual].freeze

  has_many :health_check_submissions, dependent: :nullify
  has_many :chat_conversations, dependent: :nullify
  has_many :projects, dependent: :destroy
  has_many :invoices, dependent: :destroy

  validates :first_name, presence: true
  validates :stage, presence: true, inclusion: { in: STAGES }
  validates :source, inclusion: { in: SOURCES }, allow_blank: true

  scope :leads, -> { where(stage: "lead") }
  scope :prospects, -> { where(stage: "prospect") }
  scope :clients, -> { where(stage: "client") }
  scope :by_stage, ->(stage) { where(stage: stage) }

  def full_name
    [ first_name, last_name ].compact_blank.join(" ")
  end
end
