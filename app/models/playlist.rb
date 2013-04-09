class Playlist < ActiveRecord::Base
  belongs_to :user
  has_many :items, class_name: "PlaylistItem", dependent: :delete_all
end
