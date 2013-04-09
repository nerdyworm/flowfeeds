class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :guid, null: false
      t.string :title, null: false
      t.text :description
      t.string :url, null: false
      t.references :artist, index: true
      t.references :feed, index: true
      t.datetime :published, null: false

      t.timestamps
    end

    add_index :tracks, :guid, unique: true
    add_index :tracks, :published
  end
end
