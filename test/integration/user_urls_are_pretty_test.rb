require 'test_helper'

class UserURLSArePrettySoPretty < ActionDispatch::IntegrationTest
  test "user name appears in url" do
    user = users(:carl)
    cause = user.causes.first

    visit user_cause_path(user.username, cause)

    assert_equal "/Carl/causes/1", user_cause_path(user.username, cause)
  end
end
