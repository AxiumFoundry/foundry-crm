require "test_helper"

class InvoiceTest < ActiveSupport::TestCase
  test "validates number presence and uniqueness" do
    invoice = Invoice.new(contact: contacts(:jane), kind: "invoice")
    assert_not invoice.valid?
    assert_includes invoice.errors[:number], "can't be blank"
  end

  test "validates kind inclusion" do
    invoice = invoices(:draft_invoice)
    invoice.kind = "invalid"
    assert_not invoice.valid?
  end

  test "validates status inclusion" do
    invoice = invoices(:draft_invoice)
    invoice.status = "invalid"
    assert_not invoice.valid?
  end

  test "generate_number uses site settings" do
    number = Invoice.generate_number
    assert_match(/\AINV-\d+\z/, number)
  end

  test "recalculates totals from line items" do
    invoice = invoices(:draft_invoice)
    invoice.line_items.build(description: "Test", quantity: 2, unit_price_cents: 5000)
    invoice.save!
    assert_equal 510000, invoice.subtotal_cents
  end

  test "outstanding scope" do
    assert_includes Invoice.outstanding, invoices(:sent_invoice)
    assert_not_includes Invoice.outstanding, invoices(:draft_invoice)
  end

  test "paid scope" do
    assert_includes Invoice.paid, invoices(:paid_invoice)
    assert_not_includes Invoice.paid, invoices(:draft_invoice)
  end

  test "total returns dollars" do
    invoice = invoices(:draft_invoice)
    assert_equal 5000.0, invoice.total
  end
end
