# require "test_helper"
#
# class AdminViewsItemsTest < ActionDispatch::IntegrationTest
#   test "admin views items" do
#     admin = create(:admin)
#     stache1 = create(:stache, retired: true)
#     stache2 = create(:stache)
#     ApplicationController.any_instance.stubs(:current_user).returns(admin)
#
#     visit admin_dashboard_path
#     click_on "View All Staches"
#
#     assert_equal admin_staches_path, current_path
#
#     within("#stache-#{stache1.id}") do
#       assert page.has_css?("img[src*='#{stache1.image_url}']")
#       assert page.has_content?(stache1.name)
#       assert page.has_content?(stache1.description)
#       assert page.has_content?(stache1.price)
#       assert page.has_content?("Retired")
#       assert page.has_content?("Edit")
#     end
#     within("#stache-#{stache2.id}") do
#       assert page.has_css?("img[src*='#{stache2.image_url}']")
#       assert page.has_content?(stache2.name)
#       assert page.has_content?(stache2.description)
#       assert page.has_content?("Active")
#       assert page.has_content?("Edit")
#     end
#   end
# end
