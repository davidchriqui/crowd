class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string :name

      t.timestamps
    end
    add_index :playlists, :name
  end
end
