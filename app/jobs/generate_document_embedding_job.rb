class GenerateDocumentEmbeddingJob < ApplicationJob
  queue_as :default

  def perform(document_id)
    document = KnowledgeDocument.find(document_id)
    embedding = RubyLLM.embed(document.content).vectors
    document.update_column(:embedding, embedding)
  end
end
