require "test_helper"

class RegisteredUserCanLogInTest < ActionDispatch::IntegrationTest
  test "a registered user can login" do
    user = users(:carl)
    visit login_path
    within '.main' do
      fill_in "Username", with: "Carl"
      fill_in "Password", with: "password"
      click_on "Login"
    end

    assert_equal user_path(User.last), current_path
    assert page.has_content?("Start dreaming, Carl :-)")
  end
end
