class VotesController < ApplicationController
  # POST /votes
  # POST /songs.json
  def create ()
    @vote = Vote.new(:user_id => params[:user_id], :song_id => params[:song_id], :positive => params[:positive])

    respond_to do |format|
      if @vote.save
        format.html { redirect_to songs_path, notice: 'Nice vote mate!' }
        format.json { render action: 'show', status: :created, location: @vote }
      else
        format.html { render action: 'new' }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end
end
