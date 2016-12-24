import Ember from 'ember';
import config from './config/environment';

const Router = Ember.Router.extend({
  location: config.locationType,
  rootURL: config.rootURL
});

Router.map(function() {
  this.route('world', function() {
    this.route('connect');
    this.route('leaderboards');
    this.route('news');
  });
});

export default Router;
