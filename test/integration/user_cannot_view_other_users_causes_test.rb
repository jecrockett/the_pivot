require "test_helper"

class UserCannotEditOtherUsersCauseTest < ActionDispatch::IntegrationTest
  test "user cannot edit other user's cause" do
    user_1 = users(:carl)
    user_2 = users(:bernie)
    cause = user_1.causes.last

    log_in(user_2)
    visit user_cause_path(user_1, cause)

    within '#cause-card-header' do
      refute page.has_link?("Edit Your Cause")
    end

    visit edit_user_cause_path(user_1, cause)

    assert_equal root_path, current_path
  end
end
