require 'test_helper'

class UserCanDeleteAccountTest < ActionDispatch::IntegrationTest
  def setup
    featured_cause_user!
    deleted_user_placeholder
    deleted_cause_placeholder
    create_featured_causes!
  end

  test "the truth" do
    user = users(:carl)
    log_in(user)

    visit edit_user_path(user)
    click_on "Delete Account"
    visit "/users/1"
    
    assert_equal root_path, current_path
  end
end
