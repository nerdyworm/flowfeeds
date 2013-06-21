//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require twitter/bootstrap/typeahead
//= require_self

$(function() {

  $("#feed_artist_name").typeahead({
    source: function(query, process) {
      var url = $('#feed_artist_name').data('autocomplete-source');

      $.ajax({
        url: url,
        data: { q: query },
        success: function(results) {
          process(results.artists.map(function(artist) {
            return artist.name;
          }));
        }
      });
    }
  });

});
