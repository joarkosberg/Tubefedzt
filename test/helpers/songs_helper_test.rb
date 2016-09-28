require 'test_helper'

class SongsHelperTest < ActionController::TestCase
  include SongsHelper

  def setup
    # Do nothing
  end

  def teardown
    # Do nothing
  end

  test "load_video returns link of song" do
    song = Song.first
    link = load_video song
    assert_equal song.link, link
  end

  test "load_video removes all votes from song" do
    song = songs(:song1)
    assert song.votes.count > 0
    load_video song
    assert_equal song.votes.count, 0
  end

end
