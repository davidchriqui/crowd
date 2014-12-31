class CreateUserPlaylists < ActiveRecord::Migration
  def change
    create_table :user_playlists do |t|
      t.references :user, index: true
      t.references :playlist, index: true
      t.boolean :is_host

      t.timestamps
    end
  end
end
