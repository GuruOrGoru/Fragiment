require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should not save user without name" do
    user = User.new(email: "test@example.com", password: "password")
    assert_not user.save
  end

  test "should save user with name" do
    user = User.new(email: "test@example.com", password: "password", name: "Test User")
    assert user.save
  end

  test "user can be admin" do
    user = User.new(email: "admin@example.com", password: "password", name: "Admin User", admin: true)
    assert user.save
    assert user.admin?
  end

  test "user is not admin by default" do
    user = User.new(email: "user@example.com", password: "password", name: "Regular User")
    assert user.save
    assert_not user.admin?
  end
end
