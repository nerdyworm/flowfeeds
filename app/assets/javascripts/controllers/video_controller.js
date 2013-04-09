//require= controllers/playable_controller

Flowfeeds.VideoController = Flowfeeds.PlayableController.extend({
  isVideo: true,

  setup: function(video) {
    this.set('content', video);
    this.video = new YT.Player('video-player', this.createVideoOptions());
    this.trackWatch();
  },

  createVideoOptions: function() {
    var controller = this;
    return {
      height: 200,
      width: 200,
      videoId: this.get('youtube_id'),
      playerVars: {
        autoplay: 1,
        controls: 0
      },
      events: {
        onReady: function() { controller.onPlayerReady(); },
        onStateChange: function(state) { controller.onStateChange(state); }
      }
    };
  },

  onPlayerReady: function() {
    this.set('duration', this.video.getDuration() * 1000);
    this.beginUpdateLoop();
  },

  beginUpdateLoop: function() {
    var controller = this,
        video = this.video;

    this.updateLoop = setInterval(function() {
      if(video && video.getCurrentTime) {
        controller.set('position', video.getCurrentTime() * 1000);
      }
    }, 250);
  },

  stopUpdateLoop: function() {
    clearInterval(this.updateLoop);
  },

  onStateChange: function(state) {
    switch(state.data) {
      case YT.PlayerState.ENDED:
        this.send('next');
        break;
      case YT.PlayerState.PLAYING:
        this.set('isPlaying', true);
        break;
      case YT.PlayerState.PAUSED:
        this.set('isPlaying', false);
        break;
    }
  },

  stop: function() {
    if(this.video) {
      this.stopUpdateLoop();
      this.video.destroy();
      this.video = null;
      this.reset();
    }
  },

  pause: function() {
    this.video.pauseVideo();
  },

  resume: function() {
    this.video.playVideo();
  },

  jump: function(float) {
    this.video.seekTo(float * this.video.getDuration());
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

  trackWatch: function() {
    Flowfeeds.Play.trackPlay(this.get('content'));
  }
});
