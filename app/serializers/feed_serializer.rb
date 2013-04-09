class FeedSerializer < ActiveModel::Serializer
  attributes :id, :title, :genre_id, :unplayed, :thumb, :image_medium, :image, :description, :website, :url

  def thumb
    object.image.thumb.to_s
  end

  def image_medium
    object.image.medium.to_s
  end

  def image
    object.image.to_s
  end
end
