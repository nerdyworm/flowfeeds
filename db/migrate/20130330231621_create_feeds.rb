class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :title
      t.references :genre, index: true, null: false
      t.references :artist, index: true
      t.string :url, null: false
      t.string :website
      t.text :description
      t.string :image

      t.timestamps
    end

    add_index :feeds, :url, unique: true
  end
end
