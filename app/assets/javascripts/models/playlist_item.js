Flowfeeds.PlaylistItem = Ember.ObjectProxy.extend({
  idx: null,
  itemId: null,
  playlist: null,

  content: null,
  isPlaylistItem: true,
  destroyRecord: function() {
    return Ember.$.ajax({
      url: "/playlist_items/%@".fmt(this.get('itemId')),
      type: "DELETE",
      context: this,
      success: function() {
        this.get('playlist.items').removeObject(this);
      }
    });
  },

  setProperties: function(props) {
    this._super({
      idx: props.idx,
      itemId: props.id,
      content: this._getPlayable(props)
    });
  },

  _getPlayable: function(params) {
    return Flowfeeds.store.load(
      Flowfeeds[params.playable_type],
      params.playable
    );
  }
});
