require "test_helper"

class KnowledgeDocumentTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper
  test "requires title" do
    doc = KnowledgeDocument.new(content: "some content")
    assert_not doc.valid?
    assert_includes doc.errors[:title], "can't be blank"
  end

  test "requires content" do
    doc = KnowledgeDocument.new(title: "Some Title")
    assert_not doc.valid?
    assert_includes doc.errors[:content], "can't be blank"
  end

  test "defaults to active" do
    doc = KnowledgeDocument.create!(title: "Test", content: "Content")
    assert doc.active?
  end

  test "active scope returns only active documents" do
    assert_includes KnowledgeDocument.active, knowledge_documents(:services_doc)
    assert_not_includes KnowledgeDocument.active, knowledge_documents(:inactive_doc)
  end

  test "enqueues embedding job on create" do
    assert_enqueued_with(job: GenerateDocumentEmbeddingJob) do
      KnowledgeDocument.create!(title: "New Doc", content: "New content for embedding")
    end
  end

  test "enqueues embedding job on content change" do
    doc = knowledge_documents(:services_doc)
    assert_enqueued_with(job: GenerateDocumentEmbeddingJob) do
      doc.update!(content: "Updated content for re-embedding")
    end
  end
end
