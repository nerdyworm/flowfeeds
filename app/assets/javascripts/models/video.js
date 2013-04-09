Flowfeeds.Video = Ember.Object.extend({
  youTubeUrl: function() {
    return "http://www.youtube.com/embed/%@?autoplay=1&enablejsapi=1&version=3".fmt(this.get('youtube_id'));
  }.property('youtube_id'),

  thumb: function() {
    return "http://img.youtube.com/vi/%@/1.jpg".fmt(this.get('youtube_id'));
  }.property('youtube_id')
});

Flowfeeds.VIDEO_META = Ember.Object.create({
  total: null,
  unplayed: null
});

Flowfeeds.Video.reopenClass({
  query: function(params) {
    return $.getJSON("/videos", params).then(function(json) {
      Flowfeeds.Video.loadMeta(json.meta);
      return Flowfeeds.store.loadMany(Flowfeeds.Video, json.videos);
    });
  },

  loadMeta: function(meta) {
    Flowfeeds.VIDEO_META.set('page', meta.page);
    Flowfeeds.VIDEO_META.set('total', meta.total);
    Flowfeeds.VIDEO_META.set('unplayed', meta.unplayed);
  }
});
