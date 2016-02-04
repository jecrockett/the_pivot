# require "test_helper"
#
# class ViewFooterLinksTest < ActionDispatch::IntegrationTest
#   test "user can use footer links to view root and about" do
#     visit root_path
#     click_on("About Us")
#
#     assert_equal current_path, about_path
#
#     click_on("Private Stache")
#
#     assert_equal current_path, root_path
#
#     visit new_user_path
#     click_link("Private Stache")
#
#     assert_equal current_path, root_path
#   end
# end
