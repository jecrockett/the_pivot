require "test_helper"

class UserCanOnlyModifyOwnAccountInfoTest < ActionDispatch::IntegrationTest
  test "user can modify own account info" do
    user = users(:carl)

    log_in(user)
    visit user_path(user)
    click_on "Edit Account Info"

    assert_equal edit_user_path(user), current_path

    fill_in "Username", with: "Jenny"
    fill_in "Password", with: "new_password"
    fill_in "Password confirmation", with: "new_password"
    click_on "Update Account"

    assert page.has_content?("Jenny")

    assert_equal user_path(user), current_path
  end

  test "visitor cannot modify an account" do
    featured_cause_user!
    create_featured_causes!
    user = users(:carl)

    visit user_path(user)
    refute page.has_content?("Edit Account Info")

    visit edit_user_path(user)

    assert_equal root_path, current_path
  end
end
