require 'test_helper'

class CauseOwnerCanAddAnotherCauseAdminTest < ActionDispatch::IntegrationTest
  test "cause owner can add another user as a cause admin" do
    user1 = users(:carl)
    user2 = users(:bernie)
    log_in(user1)
    visit user_cause_path(user1, user1.causes.first)

    within('#admins') do
      refute page.has_content?("#{user2.username}")
    end

    click_on "Edit Your Dream"
    fill_in "Add another dream admin (enter a user's email)", with: user2.email
    click_on "Submit"

    within('#admins') do
      assert page.has_content?("#{user2.username}")
    end
  end
end
