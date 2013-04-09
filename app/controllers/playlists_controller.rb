class PlaylistsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :json

  def index
    playlists = current_user.playlists

    respond_with playlists
  end

  def create
    playlist = current_user.playlists.create(playlist_params)

    render json: playlist
  end

  def destroy
    playlist = current_user.playlists.find(params[:id])
    playlist.destroy

    render nothing: true
  end

  def add
    playlist = current_user.playlists.find(params[:id])
    item = playlist.items.create(playable: playable)

    render json: item
  end

  private

  def playlist_params
    params.require(:playlist).permit(:name)
  end

  def playable
    if params[:track_id]
      Track.find(params[:track_id])
    elsif params[:video_id]
      Video.find(params[:video_id])
    end
  end
end
