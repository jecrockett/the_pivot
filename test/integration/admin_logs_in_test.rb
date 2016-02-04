# require "test_helper"
#
# class AdminLogsInTest < ActionDispatch::IntegrationTest
#   test "admin can login" do
#     admin = User.create(username: "Carl", password: "password", role: 1)
#
#     visit login_path
#     fill_in "Username", with: "Carl"
#     fill_in "Password", with: "password"
#     click_on "Login"
#
#     assert_equal admin_dashboard_path, current_path
#     assert page.has_content?("Admin StacheBoard")
#   end
# end
