Flowfeeds.PlayerController = Ember.ObjectController.extend({
  play: function(playable) {
    if(this.get('content') === playable) {
      return;
    }

    this.stop();
    playable.setup();
    this.set('target',  playable);
    this.set('content', playable);
  },

  stop: function() {
    if(this.get('content'))
      this.get('content').send('stop');
  }
});
