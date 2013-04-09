class AddAdminToken < ActiveRecord::Migration
  def change
    add_column :admins, :authentication_token, :string
    add_index :admins, :authentication_token, unique: true
  end
end
