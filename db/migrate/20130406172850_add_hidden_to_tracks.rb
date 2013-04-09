class AddHiddenToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :hidden, :boolean, null: false, default: false
    add_index :tracks, :hidden

    add_column :tracks, :promoted, :boolean, null: false, default: false
    add_index :tracks, :promoted
  end
end
