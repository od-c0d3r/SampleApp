require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get users_new_url
    assert_response :success
  end

  test "should redirect index in not logged in" do
    get users_path
    assert_redirected_to login_path
  end 
end
