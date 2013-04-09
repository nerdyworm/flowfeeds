Flowfeeds.Picks = Ember.Object.extend(Flowfeeds.HasManyTracks, {
  tracksURL: "/tracks?promoted=true",

  init: function() {
    this.set('tracks', []);
    this._super();
  }
});


Flowfeeds.Picks.reopenClass({
  // There can be only one picks model
  load: function(id) {
    var picks = Flowfeeds.store.load(Flowfeeds.Picks, {id: -1});
    picks.lazyLoadTracks();
    return picks;
  }
});
