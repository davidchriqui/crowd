class Api::V1::PlaylistsController < ApplicationController
  respond_to :json

  before_action :authenticate_with_token!, only: [:create]
  before_action :is_playlist_host, only: [:destroy]

  def is_playlist_host
    render json: { errors: "Your are not hosting this playlist" },
           status: :unauthorized unless current_user.user_playlists
  end

  def show
    respond_with Playlist.find(params[:id])
  end

  def index
    respond_with current_user.playlists
  end

  def create
    playlist = current_user.playlists.build(playlist_params)
    if playlist.save
      user_playlist = UserPlaylist.new
      user_playlist.user = current_user
      user_playlist.playlist=playlist
      user_playlist.is_host = true
      if user_playlist.save
        render json: playlist, status: 201, location: [:api, playlist]
      else
        playlist.destroy
        render json: { errors: playlist.errors }, status: 422
      end
    else
      render json: { errors: playlist.errors }, status: 422
    end
  end


  def update
    playlist = current_user.playlist.find(params[:id])
    if playlist.update(playlist_params)
      render json: playlist, status: 200, location: [:api, playlist]
    else
      render json: { errors: playlist.errors }, status: 422
    end
  end

  def destroy
    playlist = Playlist.find(params[:id])
    playlist.destroy
    head 204
  end

  private

  def playlist_params
    params.require(:playlist).permit(:name)
  end
end
