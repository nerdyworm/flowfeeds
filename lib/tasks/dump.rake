task :dump => :environment do
  genres = []

  Genre.all.each do |g|
    genres << {
      name: g.name,
      feed_urls: g.feeds.pluck(:url)
    }
  end

  File.open("feeds.yaml", "w") do |file|
    file.write(genres.to_yaml)
  end
end
