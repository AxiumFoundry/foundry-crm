require "test_helper"

class LineItemTest < ActiveSupport::TestCase
  test "validates description presence" do
    item = LineItem.new(invoice: invoices(:draft_invoice), quantity: 1, unit_price_cents: 100)
    assert_not item.valid?
    assert_includes item.errors[:description], "can't be blank"
  end

  test "calculates total_cents" do
    item = LineItem.new(description: "Test", quantity: 3, unit_price_cents: 5000, invoice: invoices(:draft_invoice))
    item.valid?
    assert_equal 15000, item.total_cents
  end

  test "unit_price returns dollars" do
    item = line_items(:design_work)
    assert_equal 3000.0, item.unit_price
  end
end
