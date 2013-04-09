class CreatePlays < ActiveRecord::Migration
  def change
    create_table :plays do |t|
      t.references :track, null: false, index: true
      t.references :user, null: false, index: true

      t.timestamps
    end
  end
end
