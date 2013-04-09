class MigrateSti < ActiveRecord::Migration
  def change
    create_table :playables do |t|
      t.string :guid, null: false
      t.string :title, null: false
      t.text :description
      t.datetime :published
      t.boolean :hidden, null: false, default: false
      t.boolean :promoted, null: false, default: false
      t.string :url
      t.string :type

      t.references :feed, index: true
      t.references :artist, index: true

      t.timestamps
    end

    add_index :playables, :guid, unique: true
    add_index :playables, :type

    results = ActiveRecord::Base.connection.execute("select * from videos");
    results.each do |video|
      Video.create!(video.except("id", "created_at", "updated_at"))
    end

    results = ActiveRecord::Base.connection.execute("select * from tracks");
    results.each do |track|
      Track.create!(track.except("id", "created_at", "updated_at"))
    end

    Play.delete_all
    remove_column :plays, :track_id

    add_column :plays, :playable_id, :integer, null: false
    add_index :plays, :playable_id

    drop_table :videos
    drop_table :tracks
    drop_table :watches

    remove_column :playlist_items, :playable_type

    PlaylistItem.delete_all
  end
end
