require 'test_helper'

class UserCannotEditOthersAccountInfoTest < ActionDispatch::IntegrationTest

  def setup
    featured_cause_user!
    create_featured_causes!
  end

  test "user cannot edit another user's account" do
    user_1 = users(:carl)
    user_2 = users(:bernie)
    log_in(user_2)
    visit user_path(user_1)

    within '.user-header' do
      refute page.has_link?("Edit Account Info")
      refute page.has_link?("Build Your Dream")
    end

    visit edit_user_path(user_1)

    assert_equal root_path, current_path
  end

end
