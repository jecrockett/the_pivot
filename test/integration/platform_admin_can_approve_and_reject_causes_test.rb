require 'test_helper'

class AdminCanApproveAndRejectCausesTest < ActionDispatch::IntegrationTest

  test "admin can accept causes" do
    admin = users(:admin)
    user = users(:carl)
    cause = user.causes.last
    log_in(admin)

    assert_equal "pending", cause.current_status

    within(".#{cause.title.delete(' ')}") do
      click_on "Accept"
    end

    assert_equal "active", user.causes.last.current_status
  end

  test "admin can reject causes" do
    admin = users(:admin)
    user = users(:carl)
    cause = user.causes.last
    log_in(admin)

    assert_equal "pending", cause.current_status

    within(".#{cause.title.delete(' ')}") do
      click_on "Reject"
    end

    assert_equal "inactive", user.causes.last.current_status
  end
end
