class DocumentFinder
  def initialize(query)
    @query = query
  end

  def find_relevant
    embedding = RubyLLM.embed(@query).vectors
    KnowledgeDocument.active.nearest_neighbors(:embedding, embedding, distance: "cosine").limit(3)
  rescue StandardError => e
    Rails.logger.error("DocumentFinder error: #{e.message}")
    KnowledgeDocument.none
  end
end
