Flowfeeds.HasManyTracks = Ember.Mixin.create({
  currentPageOfTracks: 1,
  didLoadFirstPageOfTracks: false,

  isLoading: false,

  lazyLoadTracks: function() {
    if(!this.get('didLoadFirstPageOfTracks')) {
      this.set('didLoadFirstPageOfTracks', true);
      this.loadTracks(1);
    }
  },

  loadTracks: function(page) {
    this.set('isLoading', true);
    return Ember.$.ajax({
      url: this.buildTracksURL(),
      data: { page: page || 1 },
      context: this,
      success: function(json) {
        this.set('isLoading', false);
        this.set('currentPageOfTracks', page);
        this.set('tracksTotal', json.meta.total);
        this.get('tracks').pushObjects(
          Flowfeeds.store.loadMany(Flowfeeds.Track, json.tracks)
        );
      }
    });
  },

  buildTracksURL: function() {
    return this.get('tracksURL').fmt(this.get('id'));
  },

  loadNextPageOfTracks: function() {
    if(this.shouldNotLoadMore()) return;

    this.loadTracks(this.get('currentPageOfTracks') + 1);
  },

  hasMoreTracks: function() {
    return this.get('tracksTotal') > this.get('tracks.length');
  }.property('tracksTotal', 'tracks.length'),


  shouldNotLoadMore: function() {
    return this.get('isLoading') || !this.get("hasMoreTracks");
  }
});
