Flowfeeds.Router.map(function() {
  this.route('about');
  this.route('feed',  { path: 'feed/:feed_id' });
  this.route('genre', { path: 'genre/:genre_id' });
  this.route('login');
  this.route('playlist', { path: 'playlist/:playlist_id' });
  this.route('picks');
  this.route('register');
  this.route('sandbox');
  this.route('videos');
  this.route('welcome');
});

