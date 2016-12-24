import Ember from 'ember';

export default Ember.Component.extend({
  didReceiveAttrs() {
    console.log('attrs', this.attrs);
  }


});
