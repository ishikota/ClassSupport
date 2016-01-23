require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name:"Example User", student_id:"B1578048",
                    password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "  "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.student_id = " "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a"*51
    assert_not @user.valid?
  end

  test "student id should be 8 charactars" do
    @user.student_id = "B15780488"
    assert_not @user.valid?
  end

  test "student_id should be saves as lower-case" do
    upper_student_id = "B1578048"
    @user.student_id = upper_student_id
    @user.save
    assert_equal upper_student_id.downcase, @user.reload.student_id
  end

  test "student id validation" do
    invalid_id = %w[bc123456 12345678]
    invalid_id.each do |id|
      @user.student_id = id
      assert_not @user.valid? , "#{id} should not be valid"
    end
  end

  test "sudent id should be unique" do
    duplicate_user = @user.dup
    duplicate_user.student_id = @user.student_id.downcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password shold be present" do
    @user.password = @user.password_confirmation = ""*6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a"*5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end

end
