class Playlist < ActiveRecord::Base
  has_many :songs, dependent: :destroy
  has_many :user_playlists, dependent: :destroy
  has_many :users, :through => :user_playlists
end
