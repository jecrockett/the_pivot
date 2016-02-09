require "test_helper"

class RegisteredUserCanLogInTest < ActionDispatch::IntegrationTest
  test "a registered user can login" do
    user = users(:carl)
    visit login_path
    within '.main' do
      fill_in "Email", with: "carl69beef@geocities.com"
      fill_in "Password", with: "password"
      click_on "Login"
    end

    assert_equal user_path(user), current_path
    assert page.has_content?("Start dreaming, Carl :-)")
  end
end
