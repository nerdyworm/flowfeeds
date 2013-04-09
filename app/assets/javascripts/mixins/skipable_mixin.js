Flowfeeds.Skipable = Ember.Mixin.create({
  needs: ['player'],

  currentIndex: function() {
    var current = this.get('controllers.player.content');
    return this.indexOf(current);
  },

  next: function() {
    var index = this.currentIndex();
    if(this.inBounds(index) && this.inBounds(index + 1)) {
      var next = this.objectAt(index + 1);
      this.get('controllers.player').play(next);
    }
  },

  previous: function() {
    var index = this.currentIndex();
    if(this.inBounds(index) && this.inBounds(index - 1)) {
      var next = this.objectAt(index - 1);
      this.get('controllers.player').play(next);
    }
  },

  inBounds: function(index) {
    return index > -1 && index < this.get('length');
  }
});

