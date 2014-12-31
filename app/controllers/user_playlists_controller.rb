class UserPlaylistsController < ApplicationController
  respond_to :json

  before_action :authenticate_with_token!, only: [:create, :destroy]

  def show
    respond_with UserPlaylist.find(params[:id])
  end

  def index
    respond_with UserPlaylist.all
  end

  def create
    user_playlist = current_user.user_playlists.build(user_playlist_params)
    if user_playlist.save
      render json: user_playlist, status: 201, location: [:api, user_playlist]
    else
      render json: { errors: user_playlist.errors }, status: 422
    end
  end


  def destroy
    user_playlist = UserPlaylist.find(params[:id])
    user_playlist.destroy
    head 204
  end

  private

  def user_playlist_params
    params.require(:user_playlist).permit(:user_id, :playlist_id, :is_host)
  end
end
