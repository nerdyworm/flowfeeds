Ember.Application.initializer({
  name: "currentUser",
  initialize: function(container) {
    if(window.current_user) {
      var user = Flowfeeds.store.load(Flowfeeds.User, window.current_user);
      Flowfeeds.set('user', user);
    }

    if(window.unplayed_video_count) {
      Flowfeeds.VIDEO_META.set('unplayed', window.unplayed_video_count);
    }
  }
});
