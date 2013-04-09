(function() {
  var videos;

  Flowfeeds.VideosRoute = Ember.Route.extend({
    model: function() {
      if('undefined' === typeof videos) {
        videos = [];

        Flowfeeds.Video.query().then(function(results) {
          videos.pushObjects(results);
        });
      }

      return videos;
    }
  });
})();
