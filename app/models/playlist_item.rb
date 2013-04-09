class PlaylistItem < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :playable

  before_create :set_idx

  default_scope { order(:idx) }

  def set_idx
    self.idx = (playlist.items.maximum(:idx) || 0) + 1
  end
end
