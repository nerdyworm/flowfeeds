Flowfeeds.IndexRoute = Ember.Route.extend({
  model: function() {
    return Flowfeeds.Latest.load();
  },

  events: {
    more: function() {
      this.modelFor('index').loadNextPageOfTracks();
    }
  }
});
