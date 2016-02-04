require "test_helper"

class VisitorCreatesAccountTest < ActionDispatch::IntegrationTest
  test "visitor signs up" do
    visit new_user_path

    fill_in "Username", with: "carl"
    fill_in "Email", with: "carl@example.com"
    fill_in "Password", with: "pass"
    fill_in "Password confirmation", with: "pass"
    click_on "Create Account"

    user = User.last
    assert_equal user_path(user), current_path
  end

  test "visitor attempts to donate and gets redirected to sign up" do
    cause1 = causes(:cereal_machine)

    visit user_cause_path(cause1.user, cause1)
    fill_in "Amount", with: 100
    click_on "Fund This Dream"

    assert_equal new_user_path, current_path
    assert page.has_content?("Please create an account or login to donate")

    fill_in "Username", with: "carl"
    fill_in "Email", with: "carl@example.com"
    fill_in "Password", with: "pass"
    fill_in "Password confirmation", with: "pass"
    click_on "Create Account"

    assert_equal user_cause_path(cause1.user, cause1), current_path
  end
end
