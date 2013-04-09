Ember.Application.initializer({
  after: "currentUser",
  name: "loadPlaylists",
  initialize: function(container) {
    if(Ember.isEmpty(Flowfeeds.get('user'))) return;

    if(window.playlists) {
      var playlists = Flowfeeds.store.loadMany(Flowfeeds.Playlist, window.playlists);
      var playlistsController = container.lookup('controller:playlists');
      playlistsController.set('content', playlists);
    }
  }
});
