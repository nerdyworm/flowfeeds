Ember.Handlebars.registerBoundHelper('formatTime', function(ms) {
  var x = ms / 1000,
      seconds = x % 60 >> 0,
      minutes = x / 60 % 60 >> 0,
      hours   = x / 3600 % 60 >> 0;

  if(seconds < 10) seconds = "0" + seconds;
  if(minutes < 10) minutes = "0" + minutes;

  if(hours === 0) {
    hours = "";
  } else {
    hours = hours + ":";
  }

  return hours + minutes + ":" + seconds;
});

Ember.Handlebars.registerBoundHelper('formatDateTime', function(dateString) {
  var date = new Date(dateString);
  return date.toLocaleDateString();
});
