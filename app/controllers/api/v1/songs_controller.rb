class Api::V1::SongsController < ApplicationController

  respond_to :json

  before_action :authenticate_with_token!, only: [:create, :update]

  def show
    respond_with Song.find(params[:id])
  end

  def index
    respond_with Song.all
  end

  def update
    if Song.where('spotify_id = ? AND playlist_id = ?', params[:spotify_id], params[:playlist_id]).update_all({:played => true})
      render json: "ok", status: 200
    else
      render json: { errors: "error" }, status: 422
    end
  end

  def create
    song = current_user.songs.build(song_params[:song])
    if song.map(&:save)
      render json: song, status: 201
    else
      render json: { errors: song.errors }, status: 422
    end
  end

  def destroy
    song = Song.find(params[:id])
    song.destroy
    head 204
  end

  private

  def song_params
    params.permit(:song => [:spotify_id, :user_id, :playlist_id])
  end
end
