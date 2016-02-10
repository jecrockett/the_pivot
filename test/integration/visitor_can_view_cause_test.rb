require "test_helper"

class VisitorCanViewCauseTest < ActionDispatch::IntegrationTest
  test "visitor can view cause" do
    user = users(:carl)
    cause = causes(:cereal_machine)

    visit user_cause_path(user.username, cause)

    assert page.has_content?("#{cause.title}")
    assert page.has_content?("#{cause.description}")
  end
end
