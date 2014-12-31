class AddPlayedToSong < ActiveRecord::Migration
  def change
    add_column :songs, :played, :boolean, :default => false
  end
end
