require 'test_helper'

class UserCanDeleteAccountTest < ActionDispatch::IntegrationTest
  test "the truth" do
    featured_cause_user!
    create_featured_causes!
    user = users(:carl)
    log_in(user)

    visit edit_user_path(user)
    click_on "Delete Account"
    visit user_path(user)
    assert_equal root_path, current_path
  end
end
