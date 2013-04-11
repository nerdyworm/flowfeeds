Flowfeeds.RegisterController = Ember.Controller.extend({
  email: null,
  password: null,
  errors: null,

  submit: function() {
    this.set('errors', null);
    Ember.$.ajax({
      url: "registrations",
      type: "POST",
      data: {
        registration: {
          email: this.get('email'),
          password: this.get('password')
        }
      },

      context: this,
      success: function(json) {
        Ember.run(this, function() {
          var user = Flowfeeds.store.load(Flowfeeds.User, json.user);
          this.send('userDidLogin', user);
        });

        this.reset();
        this.transitionToRoute('welcome');
      },

      error: function(xhr) {
        var json = $.parseJSON(xhr.responseText);
        this.set('errors', json.errors);
      }
    });
  },

  reset: function() {
    this.set('email', null);
    this.set('password', null);
  }
});
