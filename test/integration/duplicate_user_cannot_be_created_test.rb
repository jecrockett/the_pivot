# require "test_helper"
#
# class DuplicateUserCannotBeCreatedTest < ActionDispatch::IntegrationTest
#   test "duplicate user cannot be created" do
#     User.create(username: "Carl", password: "password")
#     visit new_user_path
#     fill_in "Username", with: "Carl"
#     fill_in "Password", with: "password"
#     fill_in "Password confirmation", with: "password"
#     click_on "Create Account"
#
#     assert page.has_content?("Username has already been taken")
#   end
# end
