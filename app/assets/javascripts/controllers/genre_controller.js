Flowfeeds.GenreController = Ember.ObjectController.extend({
  isExpanded: false,

  toggle: function() {
    this.toggleProperty('isExpanded');
    this.get('content').loadFeeds();
  }
});
