import Ember from 'ember';

export default Ember.Component.extend({
  navigation: Ember.inject.service(),

  handle_in(payload) {
    console.log('from base');
    if (payload.actions.length) {
      for (var i = payload.actions.length - 1; i >= 0; i--) {
        const action = payload.actions[i];
        Mousetrap.unbind(action);
        Mousetrap.bind(action, (e) => {
          if (this[`${action}Key`] !== undefined) {
            this[`${actions}Key`](e);
          }
        });
      }
    }
  }
})