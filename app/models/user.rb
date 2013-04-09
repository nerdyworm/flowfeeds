class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :playlists
  has_many :items, through: :playlists
  has_many :plays, dependent: :delete_all
end
