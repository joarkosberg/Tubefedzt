require 'test_helper'

class AdminInteractionTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "Admin can enter partymode/playlist" do
    login

    get songs_party_path

    assert_response :success
  end


  test "Admin can send mail" do
    login

    get pages_user_path
    assert_response :success

    post send_mail_path, subject: 'This is a test', message: 'This is a testmessage'
    assert_response :redirect
    follow_redirect!

    assert_equal pages_user_path, path
    assert_equal 'Message was sent', flash[:notice]
  end

  private


  def login
    https!
    get "/"
    assert_response :success

    post user_session_path, 'user[email]' => users(:admin).email, 'user[password]' => 'adminadmin'
    follow_redirect!
    assert_response :success

    get pages_user_path
  end
end
