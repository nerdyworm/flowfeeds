desc "update all feeds"
task :update => :environment do
  Feed.all.each do |feed|
    Resque.enqueue(FeedUpdater, feed.id)
  end
end

desc "update a feed by id"
task :update_feed, [:id] => :environment do |t, args|
  Resque.enqueue(FeedUpdater, args[:id].to_i)
end
