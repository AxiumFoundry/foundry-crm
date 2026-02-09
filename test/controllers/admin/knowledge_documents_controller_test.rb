require "test_helper"

class Admin::KnowledgeDocumentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    post session_path, params: { email: users(:admin).email, password: "password123" }
    @document = knowledge_documents(:services_doc)
  end

  test "requires authentication for index" do
    delete session_path
    get admin_knowledge_documents_path
    assert_redirected_to root_path
  end

  test "index lists documents" do
    get admin_knowledge_documents_path
    assert_response :success
  end

  test "new renders form" do
    get new_admin_knowledge_document_path
    assert_response :success
    assert_select "form"
  end

  test "create with valid params" do
    assert_difference("KnowledgeDocument.count") do
      post admin_knowledge_documents_path, params: {
        knowledge_document: { title: "New Doc", content: "Some content" }
      }
    end
    assert_redirected_to admin_knowledge_documents_path
    assert_equal "Document created.", flash[:notice]
  end

  test "create with invalid params re-renders form" do
    assert_no_difference("KnowledgeDocument.count") do
      post admin_knowledge_documents_path, params: {
        knowledge_document: { title: "", content: "" }
      }
    end
    assert_response :unprocessable_entity
  end

  test "edit renders form" do
    get edit_admin_knowledge_document_path(@document)
    assert_response :success
    assert_select "form"
  end

  test "update with valid params" do
    patch admin_knowledge_document_path(@document), params: {
      knowledge_document: { title: "Updated Title" }
    }
    assert_redirected_to admin_knowledge_documents_path
    assert_equal "Document updated.", flash[:notice]
    assert_equal "Updated Title", @document.reload.title
  end

  test "destroy deletes document" do
    assert_difference("KnowledgeDocument.count", -1) do
      delete admin_knowledge_document_path(@document)
    end
    assert_redirected_to admin_knowledge_documents_path
    assert_equal "Document deleted.", flash[:notice]
  end
end
