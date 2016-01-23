require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: {name: "",
        student_id: "E1234567",
        password: "foo",
        password_confirmation: "bar" }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors', count:6
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count',1 do
      post_via_redirect users_path, user: {name: "Kota Ishimoto",
        student_id: "B1578048",
        password: "foobar",
        password_confirmation: "foobar" }
    end
    assert_template 'users/show'
    assert flash.key?(:success)
    assert is_logged_in?
  end
end
