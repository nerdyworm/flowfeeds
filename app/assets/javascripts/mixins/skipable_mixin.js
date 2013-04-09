Flowfeeds.Skipable = Ember.Mixin.create({
  needs: ['player'],

  currentIndex: function() {
    var id = this.get('controllers.player.id');

    return this.indexOf( this.find(function(item) {
      return item.get('id') === id;
    }));
  },

  next: function() {
    var index = this.currentIndex();
    if(this.inBounds(index) && this.inBounds(index + 1)) {
      var next = this.objectAt(index + 1);
      this.get('controllers.player').play(this.unwrapContent(next));
    }
  },

  previous: function() {
    var index = this.currentIndex();
    if(this.inBounds(index) && this.inBounds(index - 1)) {
      var next = this.objectAt(index - 1);
      this.get('controllers.player').play(this.unwrapContent(next));
    }
  },

  unwrapContent: function(object) {
    var content = object.get('content');

    if(content === null) return object;

    return content;
  },

  inBounds: function(index) {
    return index > -1 && index < this.get('length');
  }
});

