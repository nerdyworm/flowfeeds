Flowfeeds.PlayablesController = Ember.ArrayController.extend(Flowfeeds.Skipable, {
  lookupItemController: function(object) {
    var content = object.get('content'),
        constructor = null;

    if(content && content.constructor) {
      constructor = content.constructor;
    } else {
      constructor = object.constructor;
    }

    return constructor.toString().split(".")[1].toLowerCase();
  },

  removeFromPlaylist: function(item) {
    item.destroyRecord();
  }
});
