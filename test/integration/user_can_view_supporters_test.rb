require 'test_helper'

class UserCanViewSupportersTest < ActionDispatch::IntegrationTest
  test "user can view supporters of their cause" do
    user = users(:carl)
    supporter = users(:bernie)
    donation = user.causes.first.donations.first

    log_in(user)
    visit user_cause_path(user, user.causes.first)

    within('.cause_supporters') do
      assert page.has_content?(supporter.username)
    end
  end
end
