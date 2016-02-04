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

  # test "admin cannot access another user's edit page" do
  #   user = User.create(username: "user", password: "password")
  #   admin = User.create(username: "admin", password: "password", role: 1)
  #   ApplicationController.any_instance.stubs(:current_user).returns(admin)
  #
  #   visit edit_user_path(user)
  #
  #   assert page.has_content?("The page you were looking for doesn't exist.")
  # end
end
