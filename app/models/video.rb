class Video < Playable
  before_create :set_published

  def set_published
    last_published = Video.order('published desc').first.published

    if last_published.nil? || last_published <= Time.zone.now
      published = Time.zone.now
    else
      published = last_published + 1.day
    end

    self.published = published
  end

  def thumb
    "http://img.youtube.com/vi/#{youtube_id}/1.jpg"
  end

  def artist_name
    artist.try(:name)
  end

  def artist_name=(name)
    self.artist = Artist.where(name: name).first_or_create
  end

  def youtube_id=(id)
    self.guid = id
  end

  def youtube_id
    guid
  end
end
