Flowfeeds.VideosController = Ember.ArrayController.extend(Flowfeeds.Skipable, {
  needs: ['player'],

  itemController: 'video',

  isLoading: false,

  more: function() {
    if(this.shouldNotLoadMore()) return;

    this.set('isLoading', true);

    var page = Flowfeeds.VIDEO_META.get('page') + 1,
        that = this;

    return Flowfeeds.Video.query({ page: page }).then(function(videos) {
      that.set('isLoading', false);
      that.pushObjects(videos);
    });
  },

  shouldNotLoadMore: function() {
    return this.get('isLoading') || !this.get("isMore");
  },

  isMore: function() {
    return this.get('length') < Flowfeeds.VIDEO_META.get('total');
  }.property('length')
});
