class VideoSerializer < ActiveModel::Serializer
  attributes :id, :title, :youtube_id, :published, :played
  has_one :artist
end
