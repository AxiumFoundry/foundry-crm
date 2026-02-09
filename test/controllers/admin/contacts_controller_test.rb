require "test_helper"

class Admin::ContactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:admin)
    post session_path, params: { email: @user.email, password: "password123" }
    @contact = contacts(:john)
  end

  test "index" do
    get admin_contacts_path
    assert_response :success
  end

  test "index filtered by stage" do
    get admin_contacts_path(stage: "lead")
    assert_response :success
  end

  test "show" do
    get admin_contact_path(@contact)
    assert_response :success
  end

  test "new" do
    get new_admin_contact_path
    assert_response :success
  end

  test "create" do
    assert_difference "Contact.count", 1 do
      post admin_contacts_path, params: {
        contact: { first_name: "New", last_name: "Person", email: "new@example.com", stage: "lead" }
      }
    end
    assert_redirected_to admin_contact_path(Contact.last)
  end

  test "edit" do
    get edit_admin_contact_path(@contact)
    assert_response :success
  end

  test "update" do
    patch admin_contact_path(@contact), params: {
      contact: { first_name: "Updated" }
    }
    assert_redirected_to admin_contact_path(@contact)
    assert_equal "Updated", @contact.reload.first_name
  end

  test "destroy" do
    assert_difference "Contact.count", -1 do
      delete admin_contact_path(@contact)
    end
    assert_redirected_to admin_contacts_path
  end
end
