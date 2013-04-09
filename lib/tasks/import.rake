task :import => :environment do
  YAML.load_file('feeds.yaml').each do |g|
    genre = Genre.where(name: g[:name]).first_or_create
    g[:feed_urls].each do |feed_url|
      genre.feeds.create(url: feed_url)
    end
  end

  YAML.load_file('videos.yaml').each do |video|
    artist = Artist.where(name: video['artist']).first_or_create
    begin
      Video.create(video.merge(artist: artist))
    rescue => e
      puts e.inspect
      pp video
    end
  end
end
