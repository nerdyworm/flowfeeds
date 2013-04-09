Flowfeeds.PlayablesController = Ember.ArrayController.extend(Flowfeeds.Skipable, {
  itemController: 'playable',
  removeFromPlaylist: function(item) {
    item.destroyRecord();
  }
});
