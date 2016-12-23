import Ember from 'ember';

export default Ember.Route.extend({
  connection: Ember.inject.service(),
  activate() {
    this.get('connection').connect(this);
  },

  handle_in(payload) {
    console.log('payload: ', payload);
  }
});
