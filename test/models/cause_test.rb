require 'test_helper'

class CauseTest < ActiveSupport::TestCase
  should validate_presence_of(:title)
  should validate_presence_of(:description)
  should validate_presence_of(:goal)
  should validate_numericality_of(:goal)
  should validate_presence_of(:user_id)
  should validate_presence_of(:category_id)

  def setup
    @cause = causes(:colonize_moon)
    @cause.donations << donations(:first, :second, :third)
  end

  test "cause should be valid" do
    assert @cause.valid?
  end

  test "title cannot be empty" do
    @cause.title = " "
    refute @cause.valid?
  end

  test "description cannot be empty" do
    @cause.description = " "
    refute @cause.valid?
  end

  test "goal cannot be empty" do
    @cause.goal = " "
    refute @cause.valid?
  end

  test "goal must be an integer" do
    @cause.goal = "mike + taylor 4 lyfe"
    refute @cause.valid?

    @cause.goal = ["mike", "and", "taytay"]
    refute @cause.valid?

    @cause.goal = 35.12
    refute @cause.valid?
  end

  test "cause must have a user id" do
    @cause.user_id = nil
    refute @cause.valid?
  end

  test "cause must have a category id" do
    @cause.category_id = nil
    refute @cause.valid?
  end

  test "amount raised returns sum of donations" do
    assert_equal 600, @cause.amount_raised

    subtraction = @cause.donations.last.amount
    @cause.donations.last.destroy

    assert_equal 600 - subtraction, @cause.amount_raised
  end

  test "donation count returns number of donations" do
    assert_equal 3, @cause.donation_count

    @cause.donations.last.destroy

    assert_equal 2, @cause.donation_count
  end

  test "total supporters returns number of unique supporters" do
    # The first two donations in the setup sequence are from the same user, so the first deletion should result in no count difference.
    assert_equal 2, @cause.total_supporters
    assert_difference '@cause.total_supporters', 0 do
      @cause.donations.first.destroy
    end
    assert_difference '@cause.total_supporters', -1 do
      @cause.donations.first.destroy
    end
  end

  test "active causes class method returns all causes with active status" do
    cause_2 = causes(:cereal_machine)
    pending_cause = causes(:bad_idea)

    assert_equal 2, Cause.active_causes.count
    assert_difference 'Cause.active_causes.count', 0 do
      pending_cause.destroy
    end
    assert_difference 'Cause.active_causes.count', -1 do
      cause_2.destroy
    end
  end

  test "pending causes class method returns all causes with pending status" do
    pending_cause = causes(:bad_idea)

    assert_equal 2, Cause.pending_causes.count
    assert_difference 'Cause.pending_causes.count', -1 do
      pending_cause.destroy
    end
  end

end
