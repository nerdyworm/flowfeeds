class Artist < ActiveRecord::Base
  has_many :feeds
  has_many :playables

  def videos
    playables.where(type: Video.to_s)
  end
end
