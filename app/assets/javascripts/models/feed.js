Flowfeeds.Feed  = Ember.Object.extend(Flowfeeds.HasManyTracks, {
  tracksURL: "/feeds/%@/tracks",
  init: function() {
    this.set('tracks', []);
    this._super();
  },

  markAsPlayed: function() {
    $.ajax({
      url: "/feeds/%@/played".fmt(this.get('id')),
      type: "POST",
      context: this,
      success: function(json) {
        this.set('unplayed', 0);
        this.get('tracks').invoke('set', 'played', true);
        Flowfeeds.Genre.loadAll();
      }
    });
  },

  reload: function() {
    Ember.$.ajax({
      url: "feeds/%@".fmt(this.get('id')),
      context: this,
      success: function(json) {
        this.setProperties(json.feed);
      }
    });
  }
});

Flowfeeds.Feed.reopenClass({
  load: function(id) {
    return $.getJSON("/feeds/" + id).then(function(json) {
      return Flowfeeds.store.load(Flowfeeds.Feed, json.feed);
    });
  },

  find: function(id) {
    return Flowfeeds.store.find(this, id);
  },

  loadGenreFeeds: function(genre) {
    return $.getJSON("/genres/" + genre.get('id') + "/feeds").then(function(json) {
      return genre.set('feeds', Flowfeeds.store.loadMany(Flowfeeds.Feed, json.feeds));
    });
  }
});

