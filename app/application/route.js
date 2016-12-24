import Ember from 'ember';

export default Ember.Route.extend({
  connection: Ember.inject.service(),
  navigation: Ember.inject.service(),

  activate() {
    this.get('connection').connect(this);
  },

  keys: [],

  handle_in(payload) {
    console.log('payload: ', payload);
    if (payload.opcode) {
      this.transitionTo(payload.opcode);
      this.get('navigation').handle_in();

    }
  },

  actions: {
    handle_out(opcode, payload = {}) {
      this.get('connection').channels[channel].push(opcode, payload);
    }
  }
});
