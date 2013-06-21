Flowfeeds.GenreRoute = Ember.Route.extend({
  setupController: function(controller, model) {
    controller.set('model', model);
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
