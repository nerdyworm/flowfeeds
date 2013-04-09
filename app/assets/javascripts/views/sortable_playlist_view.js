Flowfeeds.SortablePlaylistView = Ember.View.extend({
  didInsertElement: function() {
    var playlist = this.get('playlist');

    $(".playables").sortable({
      placeholder: 'sortable-placeholder',

      start: function(event, ui) {
        ui.item.show();
      },

      helper: function(event, ui) {
        return ui.clone().css({width: '400px'});
      },

      update: function(event, ui) {
        var idIdxs = {};
        $(this).find('.playable').each(function(index) {
          idIdxs[$(this).data("id").toString()] = index;
        });

        $(this).sortable("cancel");
        playlist.updateItemsOrder(idIdxs);
      }
    });
  }
});
