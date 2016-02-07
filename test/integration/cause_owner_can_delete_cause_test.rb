require 'test_helper'

class CauseOwnerCanDeleteCauseTest < ActionDispatch::IntegrationTest
  def setup
    featured_cause_user!
    deleted_cause_placeholder
    create_featured_causes!
  end

  test "visitor does not see delete button" do
    user1 = users(:carl)
    cause = Cause.find_by(title: "Bad Idea")

    visit user_cause_path(user1, cause)
    refute page.has_link?("Delete Dream")
  end

  test "cause owners can delete their own causes" do
    user1 = users(:carl)
    cause = Cause.find_by(title: "Bad Idea")
    Donation.create(user_id: user1.id, cause_id: cause.id, amount: 10)
    title = cause.title

    log_in(user1)
    visit user_cause_path(user1, cause)
    click_on "Delete Dream"

    assert_equal user_path(user1), current_path
    assert_nil Cause.find_by(title: "Bad Idea")
  end
end
