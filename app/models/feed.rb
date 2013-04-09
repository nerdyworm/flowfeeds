require "#{Rails.root}/lib/remote_file"

class Feed < ActiveRecord::Base
  belongs_to :genre
  belongs_to :artist
  has_many :playables, dependent: :destroy
  validates :url, presence: true, uniqueness: true

  mount_uploader :image, ImageUploader

  def self.user_unplayed(user)
    select("feeds.*, sum((plays.playable_id is null)::integer) as unplayed").
      joins("JOIN playables on (feeds.id = playables.feed_id and playables.hidden = 'f')").
      joins("LEFT OUTER JOIN plays on (plays.user_id = #{user.id.to_i} and playables.id = plays.playable_id)").
      group("feeds.id").
      order("feeds.title")
  end

  def mark_as_played(user)
    tracks.each do |track|
      Play.track(track.id, user)
    end
  end

  def unplayed
    attributes.fetch('unplayed', nil)
  end

  def update_from_feedzirra(fz)
    self.description = fz.description if description.blank?
    self.title       = fz.title if title.blank?
    self.website     = fz.url if website.blank?

    if artist.blank?
      if fz.respond_to?(:itunes_author)
        artist_name = fz.itunes_author
        self.artist = Artist.where(name: artist_name).first_or_create
      end
    end

    if image.blank?
      if fz.respond_to?(:itunes_image) && RemoteFile.exists?(fz.itunes_image)
        self.remote_image_url = fz.itunes_image
      end
    end

    save!
  end

  def add_entry(entry)
    guid = entry.guid || entry.enclosure_url
    return if playables.where(guid: guid).exists?
    return unless RemoteFile.exists?(entry.enclosure_url)

    Track.create do |track|
      track.feed = self
      track.guid = guid
      track.title = entry.title
      track.description = entry.summary
      track.published = entry.published
      track.url = entry.enclosure_url
      track.artist = artist
    end
  end

  def artist_name
    artist.try(:name)
  end

  def artist_name=(name)
    self.artist = Artist.where(name: name).first_or_create
  end
end
