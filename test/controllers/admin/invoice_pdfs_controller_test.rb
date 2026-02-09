require "test_helper"

class Admin::InvoicePdfsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:admin)
    post session_path, params: { email: @user.email, password: "password123" }
    @invoice = invoices(:draft_invoice)
  end

  test "show returns a PDF" do
    get admin_invoice_pdf_path(@invoice)
    assert_response :success
    assert_equal "application/pdf", response.content_type
  end

  test "show requires authentication" do
    delete session_path
    get admin_invoice_pdf_path(@invoice)
    assert_response :redirect
  end
end
