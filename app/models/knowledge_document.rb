class KnowledgeDocument < ApplicationRecord
  has_neighbors :embedding

  validates :title, presence: true
  validates :content, presence: true

  scope :active, -> { where(active: true) }

  after_commit :enqueue_embedding, on: [ :create, :update ], if: :saved_change_to_content?

  private

  def enqueue_embedding
    GenerateDocumentEmbeddingJob.perform_later(id)
  end
end
