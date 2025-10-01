require "test_helper"

class AdminTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = users(:one) # Assuming fixtures have admin user
    @admin_user.update(admin: true) if @admin_user
    @regular_user = users(:two) # Assuming another user
    @regular_user.update(admin: false) if @regular_user
  end

  test "admin user can access admin dashboard" do
    sign_in @admin_user
    get admin_dashboard_path
    assert_response :success
    assert_select "title", "Code Share"
  end

  test "non-admin user cannot access admin dashboard" do
    sign_in @regular_user
    get admin_dashboard_path
    assert_redirected_to root_path
    assert_equal "Access denied", flash[:alert]
  end

  test "unauthenticated user cannot access admin dashboard" do
    get admin_dashboard_path
    assert_redirected_to new_user_session_path
  end

  test "admin dashboard shows content" do
    sign_in @admin_user
    get admin_dashboard_path
    assert_response :success
    assert_select "body", /Recent Snippets/
    assert_select "body", /Recent Users/
    assert_select "body", /Stats/
  end

  private

  def sign_in(user)
    post user_session_path, params: { user: { email: user.email, password: "password" } }
  end
end
