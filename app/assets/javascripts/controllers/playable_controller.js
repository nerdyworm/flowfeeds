Flowfeeds.PlayableController = Ember.ObjectController.extend({
  needs: ['player', 'playlists'],
  isPlaying: false,
  bytesLoaded: 0,
  bytesTotal: 0,
  duration: 0,
  position: 0,

  isCurrent: function() {
    return this.get('controllers.player.id') === this.get('id');
  }.property('controllers.player.id'),

  addToPlaylist: function(playlist) {
    playlist.addItem(this.get('content'));
  }
});

