# require "test_helper"
#
# class AdminRetiresStacheFromIndexTest < ActionDispatch::IntegrationTest
#   test "admin clicks on retire and the item is updated to retired" do
#     admin = User.create(username: "admin", password: "pw", role: 1)
#     stache = create(:stache, name: "Chaplin", price: 4, description: "kljdf",
#                              retired: false)
#     ApplicationController.any_instance.stubs(:current_user).returns(admin)
#
#     visit admin_staches_path
#
#     click_on "stache-#{stache.id}-retire"
#     assert Stache.find(stache.id).retired
#
#     within("#stache-#{stache.id}") do
#       assert page.has_content?("Retired")
#       refute page.has_content?("Active")
#     end
#   end
#
#   test "admin clicks on activate and the item is updated to active" do
#     admin = User.create(username: "admin", password: "pw", role: 1)
#     stache = create(:stache, name: "Chaplin", price: 4, description: "kljdf",
#                              retired: true)
#     ApplicationController.any_instance.stubs(:current_user).returns(admin)
#
#     visit admin_staches_path
#
#     click_on "stache-#{stache.id}-activate"
#     refute Stache.find(stache.id).retired
#
#     within("#stache-#{stache.id}") do
#       assert page.has_content?("Active")
#       refute page.has_content?("Retired")
#     end
#   end
# end
