class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /songs
  # GET /songs.json
  def index
    @songs = Song.joins('LEFT JOIN votes on songs.id = votes.song_id').group(:id).order('SUM(votes.positive) desc NULLS LAST')
  end

  def party
    authorize! :manage, :song
    index
  end

  def refresh_top_songs
    index
    respond_to do |format|
      format.js
    end
  end

  def refresh_songs
    refresh_top_songs
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
  end

  # GET /songs/new
  def new
    authorize! :manage, :song
    @song = Song.new
  end

  # GET /songs/1/edit
  def edit
  end

  # POST /songs
  # POST /songs.json
  def create
    if(Song.where('link = ?', params[:link]).count == 0)
      @song = Song.new(:title => params[:title], :link => params[:link])
      respond_to do |format|
        if @song.save
          @vote = Vote.new(:user_id => current_user.id, :song_id => @song.id, :positive => 1)
          @vote.save
          format.html { redirect_to songs_path, notice: params[:title] + ' was added to list.' }
          format.json { render :show, status: :created, location: @song }
        else
          format.html { render :new }
          format.json { render json: @song.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to songs_path, :notice =>  'Song is already in list!'
    end
  end

  # PATCH/PUT /songs/1
  # PATCH/PUT /songs/1.json
  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to @song, notice: 'Song was successfully updated.' }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    authorize! :manage, :song

    @song.destroy
    respond_to do |format|
      format.html { redirect_to songs_url, notice: 'Song was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      params.require(:song).permit(:title, :link, :length)
    end
end
