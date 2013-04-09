Flowfeeds.PicksRoute = Ember.Route.extend({
  model: function() {
    return Flowfeeds.Picks.load();
  },

  events: {
    more: function() {
      this.model('picks').loadNextPageOfTracks();
    }
  }
});
