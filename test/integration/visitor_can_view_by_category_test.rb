require "test_helper"

class VisitorCanViewCausesByCategory < ActionDispatch::IntegrationTest
  test "visitor can view causes by category" do
    user = users(:carl)
    category  = categories(:tech)
    category2 = categories(:travel)
    cause  = causes(:cereal_machine)
    cause2 = causes(:colonize_moon)

    visit categories_path

    assert page.has_content?("#{category.title}")
    assert page.has_content?("#{category2.title}")

    click_on category.title

    assert_equal category_path(category), current_path
    assert page.has_content?("#{category.title}")
    assert page.has_content?("#{cause.title}")
    assert page.has_content?("#{cause.description}")
    refute page.has_content?("#{category2.title}")
    refute page.has_content?("#{cause2.title}")
    refute page.has_content?("#{cause2.description}")
  end
end
