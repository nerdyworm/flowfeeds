class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title, null: false
      t.string :youtube_id, null: false
      t.references :artist, index: true
      t.datetime :published

      t.timestamps
    end

    add_index :videos, :youtube_id, unique: true
  end
end
