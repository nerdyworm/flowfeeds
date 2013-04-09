module FeedUpdater
  @queue = :feeds

  def self.perform(feed_id)
    feed = Feed.find(feed_id)
    feedzirra = Feedzirra::Feed.fetch_and_parse(feed.url)
    feed.update_from_feedzirra(feedzirra)
    feedzirra.entries.each do |entry|
      begin
        feed.add_entry(entry)
      rescue => error
        puts error.inspect
      end
    end
  end
end
