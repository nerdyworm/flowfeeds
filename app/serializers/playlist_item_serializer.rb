class PlaylistItemSerializer < ActiveModel::Serializer
  attributes :id, :idx, :playable_type
  has_one :playable

  def playable_type
    playable.class.to_s
  end
end
