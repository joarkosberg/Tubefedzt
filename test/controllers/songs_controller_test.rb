require 'test_helper'

class SongsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @song = songs(:song1)
    sign_in users(:admin)
  end

  test "should get party (goes through index)" do
    get :party
    assert_response :success
    assert_not_nil assigns(:songs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show song" do
    get :show, id: @song
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @song
    assert_response :success
  end

  test "should update song" do
    patch :update, id: @song, song: { link: @song.link, length: @song.length, title: @song.title }
    assert_redirected_to song_path(assigns(:song))
  end

  test "should destroy song" do
    assert_difference('Song.count', -1) do
      delete :destroy, id: @song
    end

    assert_redirected_to songs_path
  end
end
