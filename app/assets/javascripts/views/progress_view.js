Flowfeeds.ProgressView = Ember.View.extend({
  classNames: 'progress'.w(),

  progressBarStyle: function() {
    return "width: " + this.get('controller.percentComplete') + "%;";
  }.property('controller.percentComplete'),

  loadingBarStyle: function() {
    return "width: " + this.get('controller.percentLoaded') + "%;";
  }.property('controller.percentLoaded'),

  click: function(event) {
    this.scrubbing = false;
    this.jumpEvent(event);
  },

  jumpEvent: function(event) {
    var float = this.getX(event) / this.$().width();
    this.get('controller').send('jump', float);
  },

  getX: function(event) {
    return event.pageX - $(event.currentTarget).offset().left;
  },

  mouseDown: function(event) {
    event.preventDefault();
    this.scrubbing = true;
  },

  mouseUp: function(event) {
    this.scrubbing = false;
  },

  mouseLeave: function(event) {
    this.scrubbing = false;
  },

  mouseMove: function(event) {
    if(this.scrubbing) this.jumpEvent(event);
  }
});

