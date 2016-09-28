require 'test_helper'

class RoutesTest < ActionDispatch::IntegrationTest
  test "test songs routes" do
    # GET song 1
    assert_routing '/songs/1', { controller: "songs", action: "show", id: "1" }

    # POST song
    assert_routing({ method: 'post', path: '/songs' }, { controller: "songs", action: "create" })
  end

  test "test user routes" do
    # POST song
    assert_routing({ method: 'post', path: '/users' }, { controller: "registrations", action: "create" })
  end

  test "test pages routes" do
    # GET user page
    assert_routing '/pages/user', { controller: "pages", action: "user" }

    # GET search page
    assert_routing '/pages/search', { controller: "pages", action: "search" }
  end

  test "test get refresh song scripts" do
    assert_routing '/songs/refresh_top_songs', { controller: "songs", action: "refresh_top_songs" }
    assert_routing '/refresh_songs', { controller: "songs", action: "refresh_songs" }
  end

end
