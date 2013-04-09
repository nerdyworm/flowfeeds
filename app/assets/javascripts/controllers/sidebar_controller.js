Flowfeeds.SidebarController = Ember.Controller.extend({
  needs: ['genres', 'playlists', 'player'],

  genres: function() {
    return this.get('controllers.genres');
  }.property(),

  playlists: function() {
    return this.get('controllers.playlists');
  }.property(),

  isVideoVisible: function() {
    return this.get('controllers.player.isVideo');
  }.property('controllers.player.isVideo')
});
