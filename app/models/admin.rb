class Admin < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable,
    :token_authenticatable
end
