Flowfeeds.Track = Ember.Object.extend({
  feed: function() {
    return Flowfeeds.Feed.find(this.get('feed_id'));
  }.property('feed_id')
});
