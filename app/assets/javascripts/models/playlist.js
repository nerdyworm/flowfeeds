//= require models/playlist_item

Flowfeeds.Playlist = Ember.Object.extend({
  items: null,

  init: function() {
    this.set('items', []);
    this._super();
  },

  loadItems: function() {
    Ember.$.ajax({
      url: "playlists/%@/playlist_items".fmt(this.get('id')),
      context: this,
      success: function(json) {
        var items = Flowfeeds.store.loadMany(Flowfeeds.PlaylistItem, json.playlist_items);

        var existing = this.get('items');
        items.forEach(function(item) {
          var found = existing.find(function(e) {
            return e.get('id') === item.get('id');
          });

          if(!found) existing.pushObject(item);
        });
      }
    });
  },

  itemsDidChange: function() {
    var items = this.get('items');
    if(items !== null) items.setEach('playlist', this);
  }.observes('items', 'items.@each'),

  addItem: function(item) {
    var type = item.constructor.toString().split(".")[1].toLowerCase() + "_id";

    data = {};
    data[type] = item.get('id');

    Ember.$.ajax({
      url: "playlists/%@/add".fmt(this.get('id')),
      data: data,
      type: "POST",
      context: this,
      success: function(json) {
        var item = Flowfeeds.store.load(Flowfeeds.PlaylistItem, json.playlist_item);
        this.get('items').pushObject(item);
      }
    });
  },

  destroyRecord: function() {
    return Ember.$.ajax({
      url: "/playlists/%@".fmt(this.get('id')),
      type: "DELETE"
    });
  },

  updateItemsOrder: function(items) {
    var updated = [];
    this.get('items').forEach(function(item) {
      var sorted = items[item.get('id').toString()];

      if(sorted !== item.get('idx')) {
        updated.push({
          id:  item.get('itemId'),
          idx: sorted
        });

        item.set('idx', sorted);
      }
    });

    return Ember.$.ajax({
      url: "/playlists/%@/playlist_items/order".fmt(this.get('id')),
      type: "POST",
      data: { playlist_items: updated }
    });
  }
});

Flowfeeds.Playlist.reopenClass({
  loadAll: function() {
    return $.getJSON("/playlists").then(function(json) {
      return Flowfeeds.store.loadMany(Flowfeeds.Playlist, json.playlists);
    });
  },

  find: function(id) {
    return Flowfeeds.store.find(this, id);
  },

  createPlaylist: function(name) {
    var promise = Ember.$.ajax({
      url: "playlists",
      type: "POST",
      data: { playlist: { name: name } }
    });

    return promise.then(function(json) {
      return Flowfeeds.store.load(Flowfeeds.Playlist, json.playlist);
    });
  }
});
