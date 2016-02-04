# require "test_helper"
#
# class AdminViewOrdersTest < ActionDispatch::IntegrationTest
#   include ActionView::Helpers::NumberHelper
#   test "admin sees all orders on the dashboard page" do
#     # And I can filter orders to display by each status type  ("Ordered", "Paid", "Cancelled", "Completed")
#
#     create_eight_orders_for_user
#     admin = User.create(username: "admin", password: "pw", role: 1)
#     ApplicationController.any_instance.stubs(:current_user).returns(admin)
#
#     visit admin_dashboard_path
#
#     assert_equal admin_dashboard_path, current_path
#     assert page.has_content?("Admin StacheBoard")
#     within("#admin-orders-table") do
#       Order.all.each do |order|
#         assert page.has_content?(order.id)
#         assert page.has_content?(order.status.capitalize)
#         assert page.has_link?("order-#{order.id}-link")
#
#         if %w(ordered).include?(order.status)
#           assert page.has_link?("order-#{order.id}-paid")
#           assert page.has_link?("order-#{order.id}-cancel")
#         end
#
#         if %w(paid).include?(order.status)
#           assert page.has_link?("order-#{order.id}-complete")
#           assert page.has_link?("order-#{order.id}-cancel")
#         end
#       end
#     end
#   end
#
#   test "admin can change status of ordered order to paid" do
#     create_eight_orders_for_user
#     admin = User.create(username: "admin", password: "pw", role: 1)
#     order = Order.find_by(status: "ordered")
#     ApplicationController.any_instance.stubs(:current_user).returns(admin)
#
#     visit admin_dashboard_path
#     click_on "order-#{order.id}-paid"
#     assert Order.find(order.id).status == "paid"
#
#     assert_equal current_path, admin_dashboard_path
#     within("#order-#{order.id}") do
#       assert page.has_content?("Paid")
#       refute page.has_content?("Ordered")
#     end
#   end
#
#   test "admin can change status of paid order to complete" do
#     create_eight_orders_for_user
#     admin = User.create(username: "admin", password: "pw", role: 1)
#     order = Order.find_by(status: "paid")
#     ApplicationController.any_instance.stubs(:current_user).returns(admin)
#
#     visit admin_dashboard_path
#     click_on "order-#{order.id}-complete"
#     assert Order.find(order.id).status == "completed"
#
#     assert_equal current_path, admin_dashboard_path
#     within("#order-#{order.id}") do
#       assert page.has_content?("Completed")
#       refute page.has_content?("Paid")
#     end
#   end
#
#   test "admin can change status of ordered order to cancelled" do
#     create_eight_orders_for_user
#     admin = User.create(username: "admin", password: "pw", role: 1)
#     order = Order.find_by(status: "ordered")
#     ApplicationController.any_instance.stubs(:current_user).returns(admin)
#
#     visit admin_dashboard_path
#     click_on "order-#{order.id}-cancel"
#     assert Order.find(order.id).status == "cancelled"
#
#     assert_equal current_path, admin_dashboard_path
#     within("#order-#{order.id}") do
#       assert page.has_content?("Cancelled")
#       refute page.has_content?("Ordered")
#     end
#   end
#
#   test "admin can change status of paid order to cancelled" do
#     create_eight_orders_for_user
#     admin = User.create(username: "admin", password: "pw", role: 1)
#     order = Order.find_by(status: "paid")
#     ApplicationController.any_instance.stubs(:current_user).returns(admin)
#
#     visit admin_dashboard_path
#     click_on "order-#{order.id}-cancel"
#     assert Order.find(order.id).status == "cancelled"
#
#     assert_equal current_path, admin_dashboard_path
#     within("#order-#{order.id}") do
#       assert page.has_content?("Cancelled")
#       refute page.has_content?("Paid")
#     end
#   end
#
#   test "admin can view show page for an order" do
#     create_eight_orders_for_user
#     admin = User.create(username: "admin", password: "pw", role: 1)
#     order = Order.first
#     ApplicationController.any_instance.stubs(:current_user).returns(admin)
#
#     visit admin_dashboard_path
#     click_on "order-#{order.id}-link"
#
#     assert admin_order_path(order), current_path
#     assert page.has_content?("Order Number: #{order.id}")
#     assert page.has_content?("First Name: #{order.first_name}")
#     assert page.has_content?("Last Name: #{order.last_name}")
#     assert page.has_content?("Address: #{order.address}")
#     assert page.has_content?("#{order.city}")
#     assert page.has_content?("#{order.state}")
#     assert page.has_content?("#{order.zipcode}")
#
#     order.staches.each do |stache|
#       within("#stache-#{stache.id}") do
#         assert page.has_link?(stache.name)
#         assert page.has_content?("#{order.quantity(stache)}")
#         assert page.has_content?(number_to_currency(order.subtotal(stache)))
#       end
#     end
#
#     assert page.has_content?("Order Status: #{order.status.capitalize}")
#     assert page.has_content?("Order Placed: #{order.formatted_created_date}")
#     assert page.has_content?("Order Complete: #{order.completed?}")
#     assert page.has_content?("Order Last Updated:\
#                               #{order.formatted_updated_date}")
#     assert page.has_content?(number_to_currency(order.total))
#   end
# end
