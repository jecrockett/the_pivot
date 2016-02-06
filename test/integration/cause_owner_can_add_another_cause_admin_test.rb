require 'test_helper'

class CauseOwnerCanAddAnotherCauseAdminTest < ActionDispatch::IntegrationTest
  test "cause owner can add another user as a cause admin" do
    user1 = users(:carl)
    user2 = users(:bernie)
    log_in(user1)
    visit user_cause_path(user1, user1.causes.first)

    refute page.has_content?("#{User.first.username}")

    click_on "Edit Your Dream"
    fill_in "Add another dream admin (enter a user's email)", with: User.first.email
    click_on "Submit"

    save_and_open_page
    assert page.has_content?("#{User.first.username}")
  end
end
