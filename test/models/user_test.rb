require "test_helper"

class UserTest < ActiveSupport::TestCase
  should validate_presence_of(:email)
  should validate_presence_of(:username)

  def setup
    @user = users(:bernie)
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.username = " "
    refute @user.valid?
  end

  test "email should be present" do
    @user.email = ""
    refute @user.valid?
  end

  test "username is limited to 25 characters" do
    @user.username = "a" * 25
    assert @user.valid?

    @user.username = "a" * 26
    refute @user.valid?
  end

  test "valid email address formats pass email validation" do
    valid_addresses = %w(bernie@feelthebern.com TSWFT4LYFE@mikedao.com Mik3+Da0@aol.hi)
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?
    end
  end

  test "invalid email address formats fail email validation" do
    invalid_addresses = %w(user@email,com Tmikeswift.com Mik3@Tay+Me.4LYFE)
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      refute @user.valid?
    end
  end

  test "email addresses cannot be duplicate" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "digest method returns password digest" do
    digest = User.digest('password')

    assert_equal digest.length, @user.password_digest.length
  end

  test "supported causes returns causes a given user supports" do
    assert_equal 2, @user.supported_causes.count
    assert_difference '@user.supported_causes.count', 1 do
      @user.donations << donations(:second)
    end
  end
end
