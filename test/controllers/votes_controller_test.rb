require 'test_helper'

class VotesControllerTest < ActionController::TestCase

  test "should create vote" do
    assert_difference('Vote.count') do
      post :create, vote: { song_id: songs(:song1).id, user_id: users(:user1).id, positive: 1 }
    end
    assert_redirected_to songs_path
  end

end
