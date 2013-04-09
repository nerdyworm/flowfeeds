class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name

      t.timestamps
    end

    add_index :artists, :name, unique: true
  end
end
