Flowfeeds.Genre = Ember.Object.extend(Flowfeeds.HasManyTracks, {
  tracksURL: "/genres/%@/tracks",

  init: function() {
    this.set('feeds', []);
    this.set('tracks', []);
    this._super();
  },

  loadFeeds: function() {
    return Flowfeeds.Feed.loadGenreFeeds(this);
  },

  markAsPlayed: function() {
    $.ajax({
      url: "/genres/%@/played".fmt(this.get('id')),
      type: "POST",
      context: this,
      success: function(json) {
        this.zeroAllUnplayed();
      }
    });
  },

  zeroAllUnplayed: function() {
    Ember.run(this, function() {
      this.set('unplayed', 0);
      this.get('feeds').invoke('set', 'unplayed', 0);
      this.get('tracks').invoke('set', 'played', true);
    });
  }
});

Flowfeeds.Genre.reopenClass({
  loadAll: function() {
    return $.getJSON("/genres").then(function(json) {
      return Flowfeeds.store.loadMany(Flowfeeds.Genre, json.genres);
    });
  },

  find: function(id) {
    return Flowfeeds.store.find(this, id);
  }
});
