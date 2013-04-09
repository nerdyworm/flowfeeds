class Genre < ActiveRecord::Base
  has_many :feeds
  has_many :playables, through: :feeds

  def self.user_unplayed(user)
    select("genres.id, genres.name, sum((plays.playable_id is null)::integer) as unplayed").
      joins("LEFT OUTER JOIN feeds on (feeds.genre_id = genres.id)").
      joins("LEFT OUTER JOIN playables on (feeds.id = playables.feed_id and playables.hidden = 'f')").
      joins("LEFT OUTER JOIN plays on (playables.id = plays.playable_id and plays.user_id = #{user.id.to_i})").
      group("genres.id, genres.name")
  end

  def unplayed
    attributes.fetch("unplayed", nil)
  end

  def mark_as_played(user)
    feeds.each do |feed|
      feed.tracks.each do |track|
        Play.track(track.id, user)
      end
    end
  end
end
