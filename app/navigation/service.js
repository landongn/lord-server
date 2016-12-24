import Ember from 'ember';

export default Ember.Service.extend({
  listeners: {},
  listenerKeys: [],
  addListener(hash, ctx) {
    if (this.listenerKeys.indexOf(hash) == -1) {
      this.listeners[hash] = ctx;
      this.listenerKeys.push(listenerKeys);
    }
  },
  unsubscribe(hash) {
    if (this.listenerKeys.indexOf(hash) == -1) {
      var id = this.listenerKeys.indexOf(hash);
      delete this.listenerKeys[hash];
      this.listenerKeys.splice(id, 1);
    }
  },

  handle_in(payload) {
    console.log('sending payload to ', this.listenerKeys.length, 'consumers');
    for (var i = this.listenerKeys.length - 1; i >= 0; i--) {
      const ctx = this.listeners[this.listenerKeys[i]].handle_in(payload);
    }
  }
});
