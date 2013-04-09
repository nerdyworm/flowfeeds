Flowfeeds.PlaylistRoute = Ember.Route.extend({
  setupController: function(controller, model) {
    model.loadItems();
    controller.set('content', model);
  }
});
