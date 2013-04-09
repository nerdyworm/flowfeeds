class CreateWatches < ActiveRecord::Migration
  def change
    create_table :watches do |t|
      t.references :user, index: true, null: false
      t.references :video, index: true, null: false

      t.timestamps
    end
  end
end
