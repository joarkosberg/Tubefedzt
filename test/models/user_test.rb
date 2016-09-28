require 'test_helper'
require 'minitest/autorun'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "user is admin" do
    @user = users(:admin)
    assert @user.admin?
  end

  test "user is not admin" do
    @user = users(:user1)
    refute @user.admin?
  end

  test "user with no role defined is not admin" do
    @user = users(:testuser )
    refute @user.admin?
  end

  test "user logged in from facebook" do
    @user = users(:facebookUser)
    assert @user.from_facebook?
  end

  test "user not logged in from facebook" do
    @user = users(:user1)
    refute @user.from_facebook?
  end

  test "picture from url allows HTTP to HTTPS redirections" do
    assert_nothing_raised { User.picture_from_url 'http://github.com' }
  end

end
