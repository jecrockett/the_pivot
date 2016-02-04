require 'test_helper'

class RegisteredUserCanMakeDonationsTest < ActionDispatch::IntegrationTest
  test "registered user can make a donation" do
    user = users(:carl)
    category = categories(:tech)
    cause = causes(:colonize_moon)

    log_in(user)
    visit user_cause_path(cause.user, cause)

    within '#amount-raised' do
      assert page.has_content?("0")
    end

    fill_in "Amount", with: 100
    click_on "Fund This Dream"
    within '#amount-raised' do
      assert page.has_content?("100")
    end
    assert_equal user_cause_path(cause.user, cause), current_path
    assert page.has_content?("Thank you for making this dream come true!")
  end
end
