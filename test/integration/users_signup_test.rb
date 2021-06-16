# frozen_string_literal: true

require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path,
           params: { user: { name: 'invalid!@#',
                             email: 'invalid!@#invalid!@#',
                             password: 'invalid!@#asd',
                             password_confirmation: 'invalid!@#' } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
  end

  test 'valid signup information' do
    get signup_path
    assert_difference 'User.count' do
      post users_path,
           params: { user: { name: 'ValidName',
                             email: 'valid@email.com',
                             password: 'validpassword',
                             password_confirmation: 'validpassword' } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    assert is_logged_in?
  end
end
