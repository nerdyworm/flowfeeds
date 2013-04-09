//require= controllers/playable_controller

Flowfeeds.TrackController =  Flowfeeds.PlayableController.extend({

  setup: function(track) {
    this.set('content', track);
    this.stop();
    this.sound = this.createSound();
    this.sound.play();
    this.set('isPlaying', true);
    this.trackPlay();
  },

  createSound: function() {
    return soundManager.createSound(this.createSoundOptions());
  },

  createSoundOptions: function() {
    var controller = this;
    return {
      id: 'current-track',
      url: this.get('url'),
      whileplaying: function() { controller.whileplaying(); },
      whileloading: function() { controller.whileloading(); },
      onfinish:     function() { controller.onfinsh();      }
    };
  },

  stop: function() {
    if(this.sound) {
      this.sound.destruct();
      this.sound = null;
      this.reset();
    }
  },

  pause: function() {
    if(this.sound) {
      this.sound.pause();
      this.set('isPlaying', false);
    }
  },

  resume: function() {
    if(this.sound) {
      this.sound.play();
      this.set('isPlaying', true);
    }
  },

  reset: function() {
    this.setProperties({
      isPlaying: false,
      bytesLoaded: 0,
      bytesTotal: 0,
      duration: 0,
      position: 0
    });
  },

  whileplaying: function() {
    this.setProperties({
      duration: this.sound.durationEstimate,
      position: this.sound.position
    });
  },

  whileloading: function() {
    this.setProperties({
      bytesLoaded: this.sound.bytesLoaded,
      bytesTotal: this.sound.bytesTotal
    });
  },

  onfinsh: function() {
    this.send('next');
  },

  jump: function(float) {
    this.sound.setPosition(float * this.sound.durationEstimate);
  },

  addToPlaylist: function(playlist) {
    playlist.addItem(this.get('content'));
  },

  trackPlay: function() {
    Flowfeeds.Play.trackPlay(this.get('content'));
  }
});
