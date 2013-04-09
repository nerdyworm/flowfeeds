Ember.Application.initializer({
  name: "loadGenres",
  initialize: function(container) {
    var genres = Flowfeeds.store.loadMany(Flowfeeds.Genre, window.genres);
    var controller = container.lookup('controller:genres');
    controller.set('content', genres);
  }
});
