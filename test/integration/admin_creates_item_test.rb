# require "test_helper"
#
# class AdminCreatesItemTest < ActionDispatch::IntegrationTest
#   test "admin can create a stache" do
#     admin = create(:admin)
#     category = Category.create(title: "cowboy")
#     Category.create(title: "hipster")
#     Category.create(title: "pirate")
#     category2 = Category.create(title: "flamboyent")
#     ApplicationController.any_instance.stubs(:current_user).returns(admin)
#
#     visit admin_dashboard_path
#     click_on "Create New Stache"
#
#     assert_equal new_admin_stache_path, current_path
#
#     fill_in "Name", with: "test_stache"
#     fill_in "Description", with: "impressive new stache"
#     fill_in "Price", with: 12
#     fill_in "Image Url", with: "http://i.imgur.com/kMx8J0g.png "
#     css_cat_1 = "#stache_categories_#{category.id}[value='#{category.id}']"
#     find(:css, css_cat_1).set(true)
#     css_cat_2 = "#stache_categories_#{category2.id}[value='#{category2.id}']"
#     find(:css, css_cat_2).set(true)
#
#     click_on "Create New Stache"
#     stache = Stache.last
#     assert_equal stache_path(stache), current_path
#     assert page.has_content?("test_stache")
#     assert page.has_content?("impressive new stache")
#     assert page.has_css?("img[src*='http://i.imgur.com/kMx8J0g.png']")
#     assert page.has_content?(category.title)
#     assert page.has_content?(category2.title)
#   end
# end
