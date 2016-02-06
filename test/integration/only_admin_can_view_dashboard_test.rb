require 'test_helper'

class OnlyAdminCanViewDashboardTest < ActionDispatch::IntegrationTest
  test "admin can view dashboard" do
    admin = users(:admin)
    log_in(admin)

    visit admin_dashboard_path

    assert page.has_content?("Admin Dashboard")
  end

  test "user cannot view dashboard" do
    user = users(:carl)
    log_in(user)

    visit admin_dashboard_path

    refute page.has_content?("Admin Dashboard")
  end
end
