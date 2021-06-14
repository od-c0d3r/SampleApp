require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:omar)
    @other_user = users(:rashad)
  end

  test "invalid user update" do
    log_in_as(@user)
    get edit_user_path(@user)
    patch user_path(@user), params: { user: { name: "invalid!@#",
                                    email:"invalid!@#invalid!@#",
                                    password:"invalid!@#asd",
                                    password_confirmation:"invalid!@#" } }
    assert_template 'users/edit'
  end

  test "valid user update with friendly forwarding" do
    get edit_user_path(@user)
    assert_not_nil session[:forwarding_url]
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    name = "foo"
    email = "fo@bar.com"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password:             "asdasd",
                                              password_confirmation:"asdasd" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when not correct user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert_redirected_to root_path
  end

  test "should redirect update when not correct user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_redirected_to root_path
  end
end
