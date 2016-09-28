require 'test_helper'

class UserInteractionTest < ActionDispatch::IntegrationTest

  test "User can log in" do
    login

    assert_equal "/songs.#{users(:testuser).id}", path
    assert_equal "Welcome in, you are awesome!", flash[:notice]
  end


  test "User can view profile" do
    login

    get pages_user_path
    assert_response :success
    assert_equal '/pages/user', path
  end


  test "User can edit his preferences" do
    login
    first_name = 'Arne Test'

    get edit_user_registration_path
    assert_response :success

    # Check that there is no user with first_name 'Arne Test'
    assert User.where('first_name = ?', first_name).count == 0

    # Update first name
    put '/users', 'user[first_name]' => first_name, 'user[current_password]' => 'testtest'

    # Check that a user with first_name 'Arne Test' exists
    assert User.where('first_name = ?', first_name).count == 1
  end


  test "User can place a vote" do
    login

    assert_equal "/songs.#{users(:testuser).id}", path

    # Place vote
    userId = users(:testuser).id
    songId = Song.first.id
    post votes_path, user_id: userId, song_id: songId, positive: 1
    follow_redirect!
    assert_response :success

    # Check that a vote exists with user's id on song id
    assert Vote.where('user_id = ? AND song_id = ?', userId, songId)
  end


  test "User can search for songs" do
    login

    assert_equal "/songs.#{users(:testuser).id}", path

    # Search for song
    keyword = 'Tubefest'
    post user_search_path, searchWord: keyword

    assert_response :success
  end


  test "User can add a song" do
    login

    assert_equal "/songs.#{users(:testuser).id}", path

    # Add song
    song_link = 'ZhzN7-Q00KU'
    song_title = 'Kygo - Raging ft. Kodaline'

    assert Song.where('link = ?', song_link).count == 0

    post songs_path, link: song_link, title: song_title

    assert Song.where('link = ?', song_link).count == 1

    follow_redirect!
    assert_equal "/songs", path
  end


  test "User gets redirected back to root path when trying to enter partymode/playlist" do
    login

    get songs_party_path

    assert_response :redirect
    follow_redirect!

    assert_equal root_path, path
  end


  test "User gets redirected back to root path when trying to send mail if path is known" do
    login

    get pages_user_path
    assert_response :success

    post send_mail_path, subject: 'This is a test', message: 'This is a testmessage'
    assert_response :redirect
    follow_redirect!

    assert_equal root_path, path
  end


  private


  def login
    https! # login via https
    get "/"
    assert_response :success

    post user_session_path, 'user[email]' => users(:testuser).email, 'user[password]' => 'testtest'
    follow_redirect!
    assert_response :success
  end
end
