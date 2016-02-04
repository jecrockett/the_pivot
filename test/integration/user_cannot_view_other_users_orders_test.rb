# require "test_helper"
#
# class UserCannotViewOtherUsersOrdersTest < ActionDispatch::IntegrationTest
#   test "user cannot view other user's orders" do
#     user_1, user_2 = create_list(:user, 2)
#     order_1 = create(:order)
#     user_1.orders << order_1
#
#     ApplicationController.any_instance.stubs(:current_user).returns(user_2)
#
#     assert_raises(ActiveRecord::RecordNotFound) do
#       visit order_path(order_1)
#     end
#   end
# end
