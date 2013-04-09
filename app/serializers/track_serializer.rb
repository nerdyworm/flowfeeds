class TrackSerializer < ActiveModel::Serializer
  attributes :id, :title, :url, :thumb, :image_medium, :image, :feed_id, :played, :published

  has_one :artist

  def thumb
    object.feed.image.thumb.to_s
  end

  def image_medium
    object.feed.image.medium.to_s
  end

  def image
    object.feed.image.to_s
  end
end
