Flowfeeds.InfiniteScrollView = Ember.View.extend({
  elementId: 'infinite',
  layout: Ember.Handlebars.compile("{{ yield }}{{ partial loader }}"),

  didInsertElement: function() {
    var view = this;
    $('#main').on('scroll', function(){
      view.onScroll();
    });
  },

  willDestroyElement: function() {
    $('#main').off('scroll');
  },

  onScroll: function() {
    if(this.isScrolledToBottom()) {
      this.get('controller').send('more');
    }
  },

  isScrolledToBottom: function() {
    var top = this.$().position().top,
        height = this.$().height(),
        containerHeight = $("#main").height();

    return Math.abs(top - containerHeight) === height;
  }
});
