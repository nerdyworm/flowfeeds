Flowfeeds.GenreRoute = Ember.Route.extend({
  setupController: function(controller, model) {
    model.lazyLoadTracks();
  },

  events: {
    more: function() {
      this.modelFor('genre').loadNextPageOfTracks();
    },

    markPlayed: function() {
      this.modelFor('genre').markAsPlayed();
    }
  }
});
