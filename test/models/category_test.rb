require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  should validate_presence_of(:title)
  should validate_uniqueness_of(:title)

  def setup
    @category = categories(:tech)
  end

  test "category is valid" do
    assert @category.valid?
  end

  test "category title cannot be blank" do
    @category.title = " "
    refute @category.valid?
  end

  test "category title cannot be duplicated" do
    new_category = Category.create(title: @category.title)
    refute new_category.valid?
  end
end
