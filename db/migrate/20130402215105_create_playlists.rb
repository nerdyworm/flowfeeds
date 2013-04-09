class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string :name, null: false
      t.references :user, index: true, null: false

      t.timestamps
    end

    create_table :playlist_items do |t|
      t.references :playlist, index: true, null: false
      t.string  :playable_type, index: true, null: false
      t.integer :playable_id, index: true, null: false
      t.integer :idx, default: 0

      t.timestamps
    end
  end
end
