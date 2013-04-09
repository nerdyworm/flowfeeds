Flowfeeds.FeedRoute = Ember.Route.extend({
  model: function(params) {
    return Flowfeeds.Feed.load(params.feed_id);
  },

  setupController: function(controller, model) {
    model.lazyLoadTracks();
    controller.set('content', model);
  },

  events: {
    more: function() {
      this.modelFor('feed').loadNextPageOfTracks();
    },

    markPlayed: function() {
      this.modelFor('feed').markAsPlayed();
    }
  }
});
