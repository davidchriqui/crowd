class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.integer :spotify_id
      t.references :playlist, index: true
      t.references :user, index: true

      t.timestamps
    end
    add_index :songs, :spotify_id
  end
end
