require 'test_helper'

class ApplicationHelperTest < ActionController::TestCase
  include ApplicationHelper

  def setup
    # Do nothing
  end

  def teardown
    # Do nothing
  end

  test "greet_user is not supposed to run when not logged in and raises and error" do
    assert_raises(NameError) { greet_user }
  end

end
