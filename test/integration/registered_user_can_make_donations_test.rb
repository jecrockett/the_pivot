require 'test_helper'

class RegisteredUserCanMakeDonationsTest < ActionDispatch::IntegrationTest
  test "registered user can make a donation" do
    user = users(:carl)
    category = categories(:tech)
    cause = causes(:colonize_moon)

    log_in(user)
    visit user_cause_path(cause.user.username, cause)

    within '#amount-raised' do
      assert page.has_content?("0")
    end

    fill_in "Amount", with: 100

    Donation.create(
      user_id: user.id,
      cause_id: cause.id,
      cause_name: cause.title,
      amount: 100,
      stripe_token: "tok_17d5KG2eZvKYlo2CVqCp7FQl"
    )

    visit user_cause_path(cause.user.username, cause)
    within '#amount-raised' do
      assert page.has_content?("100")
    end

    assert_equal user_cause_path(cause.user.username, cause), current_path
  end
end
