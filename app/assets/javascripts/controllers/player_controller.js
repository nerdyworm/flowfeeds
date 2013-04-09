Flowfeeds.PlayerController = Ember.ObjectController.extend({
  needs: ['track', 'video'],

  play: function(playable) {
    if(this.get('content') === playable) return;
    if(this.get('content')) this.send('stop');

    var controller = this.controllerFor(playable);
    controller.setup(playable);

    this.set('target',  controller);
    this.set('content', controller);
  },

  controllerFor: function(playable) {
    var content = playable.get('content');
    if(content) playable = content;

    var type = Flowfeeds.type(playable);
    return this.get('controllers.' + type);
  }
});
