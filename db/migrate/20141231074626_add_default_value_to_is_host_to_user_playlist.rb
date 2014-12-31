class AddDefaultValueToIsHostToUserPlaylist < ActiveRecord::Migration
  def change
    change_column :user_playlists, :is_host, :boolean, :default => false
  end
end
