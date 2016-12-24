import Ember from 'ember';

export default Ember.Controller.extend({
  keys: Ember.A(),

  init() {

    var self = this;
    Ember.run.later(() => {
      self.realign();
    }, 1000);
    window.addEventListener('resize', function () {
      Ember.run.debounce(() => {
        self.realign();
      }, 300);
    })
  },
  realign() {
    document.querySelector('.scene > .ember-view').style.height = window.screen.height * 0.45+'px';
    document.querySelector('.logging-display').style.height = window.screen.height * 0.15+'px';
    document.querySelector('.presence-display').style.height = window.screen.height * 0.15+'px';
    document.querySelector('.logging-display').style.width = window.screen.width * 0.35+'px';
    document.querySelector('.presence-display').style.width = window.screen.width * 0.15+'px';
  }
})