require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:kota)
  end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path , session: { student_id: "", password: "" }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information and logout" do
    get login_path
    post login_path, session: { student_id: "c1234567", password: "password" }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count:0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # あるwindowでlogoutした後，別のwindowでlogoutすると，
    # 最初のlogoutでcurrent_userがnilになってて，nilにアクセスしてしまう．
    follow_redirect!
    assert_select "a[href=?]", login_path, count:1
    assert_select "a[href=?]", logout_path, count:0
    assert_select "a[href=?]", user_path(@user), count:0
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not_nil cookies['remember_token']
  end

  test "login without remembering" do
    log_in_as(@user, remember_me: '0')
    assert_nil cookies['remember_token']
  end
end
