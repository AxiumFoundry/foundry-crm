require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "valid with email and password" do
    user = User.new(email: "test@example.com", password: "password123")
    assert user.valid?
  end

  test "invalid without email" do
    user = User.new(password: "password123")
    assert_not user.valid?
    assert_includes user.errors[:email], "can't be blank"
  end

  test "invalid with duplicate email" do
    user = User.new(email: users(:admin).email, password: "password123")
    assert_not user.valid?
    assert_includes user.errors[:email], "has already been taken"
  end

  test "authenticates with correct password" do
    user = users(:admin)
    assert user.authenticate("password123")
  end

  test "does not authenticate with wrong password" do
    user = users(:admin)
    assert_not user.authenticate("wrongpassword")
  end
end
