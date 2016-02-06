require 'test_helper'

class CauseOwnerCanAddAnotherCauseAdminTest < ActionDispatch::IntegrationTest
  test "cause owner can add another user as a cause admin" do

    user1 = users(:carl)
    user2 = users(:bernie)
    log_in(user1)
    visit user_cause_path(user1, user1.causes.first)

    click_on "Edit Your Dream"
    click_on "Add Dream Admin"

    fill_in "New Admin Email", with: User.first.email
    click_on "Add Admin"

    assert page.has_content?("Added #{User.first.username} as a cause admin...")

  end
end
