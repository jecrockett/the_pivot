require 'test_helper'

class RegisteredUserCanViewDonationsInProfileTest < ActionDispatch::IntegrationTest
  test "registered user can view donation history in user show" do
    user = users(:carl)
    category = categories(:tech)
    cause = causes(:colonize_moon)

    log_in(user)
    visit user_cause_path(cause.user.username, cause)

    within '#amount-raised' do
      assert page.has_content?("0")
    end

    fill_in "Amount", with: 159

    Donation.create(
      user_id: user.id,
      cause_id: cause.id,
      cause_name: cause.title,
      amount: 159,
      stripe_token: "tok_17d5KG2eZvKYlo2CVqCp7FQl"
    )

    visit user_cause_path(cause.user.username, cause)
    within '#amount-raised' do
      assert page.has_content?("159")
    end

    assert_equal user_cause_path(cause.user.username, cause), current_path

    visit user_path(user)

    within '#causes-supported' do
      assert page.has_content?("159")
    end
  end
end
