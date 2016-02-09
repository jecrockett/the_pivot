require 'test_helper'

class DonationTest < ActiveSupport::TestCase
  should validate_presence_of(:user_id)
  should validate_presence_of(:cause_id)
  should validate_presence_of(:amount)
  should validate_numericality_of(:amount)

  def setup
    @donation = donations(:first)
  end

  test "donation is valid" do
    assert @donation.valid?
  end

  test "user id cannot be blank" do
    @donation.user_id = " "
    refute @donation.valid?
  end

  test "cause id cannot be blank" do
    @donation.cause_id = " "
    refute @donation.valid?
  end

  test "amount must be an integer" do
    @donation.amount = " "
    refute @donation.valid?

    @donation.amount = []
    refute @donation.valid?

    @donation.amount = "penguins"
    refute @donation.valid?

    @donation.amount = 5
    assert @donation.valid?
  end

  test "username returns the name of the donator" do
    assert_equal "Bernie", @donation.username
  end


end
