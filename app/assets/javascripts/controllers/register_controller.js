Flowfeeds.RegisterController = Ember.Controller.extend({
  email: null,
  password: null,
  errors: null,

  submit: function() {
    this.set('errors', null);
    var promise = Ember.$.ajax({
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
        Ember.run(function() {
          var user = Flowfeeds.store.load(Flowfeeds.User, json.user);
          Flowfeeds.set('user', user);
        });

        this.transitionToRoute('welcome');
      },

      error: function(xhr) {
        var json = $.parseJSON(xhr.responseText);
        this.set('errors', json.errors);
      }
    });
  }
});
