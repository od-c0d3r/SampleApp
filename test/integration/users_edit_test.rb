require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:omar)
  end

  test "invalid user update" do
    get edit_user_path(@user)
    patch user_path(@user), params: { user: { name: "invalid!@#",
                                    email:"invalid!@#invalid!@#",
                                    password:"invalid!@#asd",
                                    password_confirmation:"invalid!@#" } }
    assert_template 'users/edit'
  end

  test "valid user update" do
    get edit_user_path(@user)
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
end
