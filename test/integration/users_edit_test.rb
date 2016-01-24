require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:kota)
  end

  test "unsuccesful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { name: "",
      student_id: "invalid",
      password: "foo",
      password_confirmation: "bar" }
    assert_template 'users/edit'
  end

  test "successfule edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    name = "ishikota"
    student_id = "d1234567"
    patch user_path(@user), user: {
      name: name,
      student_id: student_id,
      password: "foobar",
      password_confirmation: "foobar"
    }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal student_id, @user.student_id
  end

  test "successful edit with friendly forwarding" do
  end
end
