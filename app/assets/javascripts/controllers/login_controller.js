Flowfeeds.LoginController = Ember.Controller.extend({
  email: null,
  password: null,
  message: null,

  submit: function() {
    Ember.$.ajax({
      url: "sessions.json",
      type: "POST",
      data: {
        user: {
          email: this.get('email'),
          password: this.get('password'),
          remember_me: 1
        }
      },

      context: this,
      success: function(json) {
        this.send('userDidLogin', Flowfeeds.store.load(Flowfeeds.User, json.user));
        this.reset();
        this.transitionToRoute('welcome');
      },

      error: function(xhr) {
        var json = $.parseJSON(xhr.responseText);
        this.set('message', json.message);
      }
    });
  },

  reset: function() {
    this.set('message', null);
    this.set('password', null);
    this.set('email', null);
  }
});
