require 'test_helper'

class CauseOwnerCanAddAnotherCauseAdminTest < ActionDispatch::IntegrationTest

  def setup
    featured_cause_user!
    create_featured_causes!
  end

  test "cause owner can add another user as a cause admin" do
    user1 = users(:carl)
    user2 = users(:bernie)
    log_in(user1)
    visit user_cause_path(user1.username, user1.causes.first)

    within('#admins') do
      refute page.has_content?("#{user2.username}")
    end

    click_on "Edit Your Dream"
    fill_in "Add another dream admin (enter a user's email)", with: user2.email
    click_on "Submit"

    within('#admins') do
      assert page.has_content?("#{user2.username}")
    end

    log_out
    log_in(user2)
    visit user_cause_path(user1.username, user1.causes.first)

    assert page.has_content?('Edit Your Dream')
  end

  test "invalid emails do not add admins" do
    user1 = users(:carl)
    log_in(user1)
    visit user_cause_path(user1.username, user1.causes.first)

    within('#admins') do
      assert page.has_content?("None")
    end

    click_on "Edit Your Dream"
    fill_in "Add another dream admin (enter a user's email)", with: "fakefake@liar.com"
    click_on "Submit"

    within('#admins') do
      assert page.has_content?("None")
      refute page.has_content?("fakefake@liar.com")
    end
  end
end
