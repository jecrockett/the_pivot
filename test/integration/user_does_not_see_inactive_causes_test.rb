require 'test_helper'

class UserDoesNotSeeInactiveCausesTest < ActionDispatch::IntegrationTest

  def setup
    featured_cause_user!
    create_featured_causes!
  end

  test "visitor and user do not see another user's inactive causes" do
    user1 = users(:carl)
    user2 = users(:bernie)
    cause = causes(:bad_idea)

    visit category_path(cause.category)

    refute page.has_content?(cause.title)

    log_in(user2)
    visit user_cause_path(user1, cause)
    refute page.has_content?(cause.title)

    log_out
    log_in(user1)
    visit user_cause_path(user1, cause)
    assert page.has_content?(cause.title)
  end
end
