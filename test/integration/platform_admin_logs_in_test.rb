require "test_helper"

class AdminLogsInTest < ActionDispatch::IntegrationTest
  test "admin can login and see dashboard" do
    admin = users(:admin)

    visit login_path
    fill_in "Email", with: "admin@dreambuilder.com"
    fill_in "Password", with: "password"

    within '.main' do
      click_on "Login"
    end

    within '.container' do
      assert_equal admin_dashboard_path, current_path
      assert page.has_content?("Admin Dashboard")
      assert page.has_content?("Recent Donations")
      assert page.has_content?("Pending Causes")
    end

    click_on 'View Users'

    within '.container' do
      assert page.has_content?("All Users")
    end
  end
end
