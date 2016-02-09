require 'test_helper'

class UserCanDeleteAccountTest < ActionDispatch::IntegrationTest
  def setup
    featured_cause_user!
    deleted_user_placeholder
    deleted_cause_placeholder
    create_featured_causes!
  end

  test "users can delete their causes" do
    user = users(:carl)
    log_in(user)

    visit edit_user_path(user)
    click_on "Delete Account"
    visit "/users/1"

    assert_equal root_path, current_path
  end

  test "donation history still exists after cause deletion" do
    user = users(:carl)
    log_in(user)
    cause = user.causes.first
    donation_id = cause.donations.first.id

    visit edit_user_path(user)
    assert_equal "Automatic Dispensing Cereal Machine", cause.title
    click_on "Delete Account"

    donation =  Donation.find(donation_id)
    assert donation

    cause = Cause.find(donation.cause_id)
    assert_equal "Dead Dream", cause.title
  end

  test "causes not associated with user after deletion" do
    user = users(:carl)
    log_in(user)
    cause_id = user.causes.first.id

    visit edit_user_path(user)

    click_on "Delete Account"

    cause = Cause.find(cause_id)
    assert_equal "Dead Person", cause.user.username
  end
end
