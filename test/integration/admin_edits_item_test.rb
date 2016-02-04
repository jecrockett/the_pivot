# require "test_helper"
#
# class AdminEditsItemTest < ActionDispatch::IntegrationTest
#   test "admin edits item" do
#     admin = create(:admin)
#     stache = create(:stache, name: "Chaplin", price: 4, description: "kljdf",
#                              retired: false)
#     ApplicationController.any_instance.stubs(:current_user).returns(admin)
#
#     visit admin_staches_path
#     click_on "Edit"
#
#     assert_equal edit_admin_stache_path(stache), current_path
#
#     fill_in "Name", with: "Dictator"
#     fill_in "Price", with: 55
#     fill_in "Description", with: "You know..."
#     css_cat_1 = "#stache_retired[value='1']"
#     find(:css, css_cat_1).set(true)
#     click_on "Update Stache"
#
#     assert page.has_content?("Dictator")
#     assert page.has_content?("55")
#     assert page.has_content?("You know...")
#     assert page.has_content?("Retired")
#   end
# end
