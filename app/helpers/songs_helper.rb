module SongsHelper

  def load_video theSong
    @song = theSong
    @song.votes.destroy_all
    @song.link
  end
end
