Flowfeeds.ProgressController = Ember.ObjectController.extend({
  percentComplete: function() {
    var duration = this.get('duration');

    if(duration === 0) return 0;

    return 100 * (this.get('position') / duration);
  }.property('position', 'duration'),

  percentLoaded: function() {
    var total = this.get('bytesTotal');

    if(total === 0) return 0;

    return 100 * (this.get('bytesLoaded') / total);
  }.property('bytesLoaded', 'bytesTotal')
});
