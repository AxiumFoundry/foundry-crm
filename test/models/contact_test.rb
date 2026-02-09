require "test_helper"

class ContactTest < ActiveSupport::TestCase
  test "validates first_name presence" do
    contact = Contact.new(first_name: nil)
    assert_not contact.valid?
    assert_includes contact.errors[:first_name], "can't be blank"
  end

  test "validates stage inclusion" do
    contact = contacts(:john)
    contact.stage = "invalid"
    assert_not contact.valid?
  end

  test "validates source inclusion" do
    contact = contacts(:john)
    contact.source = "invalid"
    assert_not contact.valid?
  end

  test "allows blank source" do
    contact = contacts(:john)
    contact.source = nil
    assert contact.valid?
  end

  test "full_name with first and last" do
    contact = contacts(:john)
    assert_equal "John Doe", contact.full_name
  end

  test "full_name with first only" do
    contact = Contact.new(first_name: "Alice")
    assert_equal "Alice", contact.full_name
  end

  test "leads scope" do
    assert_includes Contact.leads, contacts(:john)
    assert_not_includes Contact.leads, contacts(:jane)
  end

  test "clients scope" do
    assert_includes Contact.clients, contacts(:jane)
    assert_not_includes Contact.clients, contacts(:john)
  end

  test "by_stage scope" do
    assert_includes Contact.by_stage("inactive"), contacts(:inactive_contact)
  end
end
