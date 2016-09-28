require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    sign_in users(:testuser)
  end

  test "should create search page" do
    get :create
    assert_response :success
  end

end
