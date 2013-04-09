Flowfeeds.Latest = Ember.Object.extend(Flowfeeds.HasManyTracks, {
  tracksURL: "/tracks",

  init: function() {
    this.set('tracks', []);
    this._super();
  }
});

Flowfeeds.Latest.reopenClass({
  // There can be only one latest model
  load: function(id) {
    var latest = Flowfeeds.store.load(Flowfeeds.Latest, {id: -1});
    latest.lazyLoadTracks();
    return latest;
  }
});
