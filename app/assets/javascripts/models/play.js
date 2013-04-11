Flowfeeds.Play = Ember.Object.extend();
Flowfeeds.Play.reopenClass({
  trackPlay: function(playable) {
    Ember.$.ajax({
      url: "/plays.json",
      type: "POST",
      data: { play: { playable_id: playable.get("id") } },
      success: function(json) {
        if(!playable.get('played')) {
          playable.set('played', true);
          Flowfeeds.Genre.loadAll();
          Flowfeeds.Feed.load(playable.get('feed_id'));
        }
      },

      error: function() {
        console.log("you should create an account");
      }
    });
  }
});
