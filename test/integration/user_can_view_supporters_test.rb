require 'test_helper'

class UserAndVisitorCanViewSupportersTest < ActionDispatch::IntegrationTest
  test "user and Visitor can view cause supporters of their cause" do
    featured_cause_user!
    create_featured_causes!
    user = users(:carl)
    supporter = users(:bernie)
    donation = user.causes.first.donations.first

    log_in(user)
    visit user_cause_path(user.username, user.causes.first)

    within('#cause_supporters') do
      assert page.has_content?(supporter.username)
    end
    log_out
    visit user_cause_path(user.username, user.causes.first)

    within('#cause_supporters') do
      assert page.has_content?(supporter.username)
    end
  end
end
