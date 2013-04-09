class Playable < ActiveRecord::Base
  include Pagination

  belongs_to :artist
  belongs_to :feed

  has_many :playlist_items, dependent: :delete_all
  has_many :plays, dependent: :delete_all

  def self.user_played(user)
    select("playables.*, (plays.playable_id is not null) as played").
      joins("left outer join plays on (plays.user_id = #{user.id} and plays.playable_id = playables.id)").
      group("playables.id, plays.playable_id")
  end

  def self.unplayed_count(user)
    joins("left outer join plays on (plays.user_id = #{user.id} and plays.playable_id = playables.id)").
      where("plays.playable_id is null").count
  end

  def self.find_with_user_played(ids, user)
    user_played(user).where(id: ids)
  end

  def self.public
    where('playables.published < now()').includes(:artist).order('playables.published desc')
  end

  def self.promoted
    where(promoted: true)
  end

  def played
    attributes.fetch("played", false)
  end
end
