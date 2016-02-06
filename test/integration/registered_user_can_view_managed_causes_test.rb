require 'test_helper'

class RegisteredUserCanViewDonationsInProfileTest < ActionDispatch::IntegrationTest
  test "registered user can view managed causes in user show" do
    user = users(:carl)
    category = categories(:tech)
    cause = causes(:colonize_moon)

    log_in(user)
    visit user_path(user)

    within '#causes-managed' do
      assert page.has_content?(cause.title)
      assert page.has_content?(cause.description)
      assert page.has_content?(cause.goal)
    end
  end
end
