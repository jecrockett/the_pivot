require 'test_helper'

class CauseOwnerCanDeleteCauseTest < ActionDispatch::IntegrationTest
  def setup
    featured_cause_user!
    deleted_cause_placeholder
    create_featured_causes!
  end

  test "visitor does not see delete button" do
    user = users(:carl)
    cause = Cause.find_by(title: "Bad Idea")

    visit user_cause_path(user.username, cause)
    refute page.has_link?("Delete Dream")
  end

  test "cause owners can delete their own causes" do
    user = users(:carl)
    cause = user.causes.first
    Donation.create(user_id: user.id, cause_id: cause.id, amount: 10)
    title = cause.title

    log_in(user)

    visit user_cause_path(user.username, cause)

    click_on "Delete Dream"

    assert_equal user_path(user), current_path
    assert_nil Cause.find_by(title: "Automatic Dispensing Cereal Machine")
  end
end
