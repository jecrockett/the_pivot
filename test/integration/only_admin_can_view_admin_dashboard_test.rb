# require "test_helper"
#
# class OnlyAdminCanViewAdminDashboardTest < ActionDispatch::IntegrationTest
#   test "only admin can view admin dashboard" do
#     admin = User.create(username: "admin", password: "pw", role: 1)
#
#     ApplicationController.any_instance.stubs(:current_user).returns(admin)
#
#     visit admin_dashboard_path
#
#     assert_equal admin_dashboard_path, current_path
#     assert page.has_content?("Admin StacheBoard")
#   end
#
#   test "user cannot view admin dashboard" do
#     user = create(:user)
#
#     ApplicationController.any_instance.stubs(:current_user).returns(user)
#
#     visit admin_dashboard_path
#
#     assert page.has_content?("doesn't exist (404)")
#   end
#
#   test "visitor cannot view admin dashboard" do
#     visit admin_dashboard_path
#
#     assert page.has_content?("doesn't exist (404)")
#   end
# end
