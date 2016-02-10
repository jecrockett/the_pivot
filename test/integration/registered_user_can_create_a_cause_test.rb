require 'test_helper'

class RegisteredUserCanCreateACauseTest < ActionDispatch::IntegrationTest
  test "cause is created with valid inputs" do
    user = users(:carl)

    log_in(user)
    visit user_path(user)
    click_on "Build a Dream"
    fill_in "Title", with: "Robot Dogs"
    fill_in "Description", with: "Light emitting diode simulation programmable logic controller wheel arm lithium ion flexibility. Register jitter watts redundancy Andrew Martin exponential assembly magnet reach trigger point ohm gripper boop serve and protect. Ohm save inverse kinematics velocity feelings exponential assembly destroy repair degrees of freedom end-effector joint motion linear robot. Bolt hydraulic gripper laser solar jerk jitter ohm. Saw current nut cam error trigger point scale."
    fill_in "Goal", with: 10000
    select "Tech", from: "cause[category_id]"
    click_on "Submit"

    assert_equal user_cause_path(user.username, Cause.last), current_path
    assert "Tech", Cause.last.category
    assert page.has_content?("Robot Dogs")
  end
end
