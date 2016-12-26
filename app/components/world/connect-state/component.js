import Ember from 'ember';
import Scene from '../sceneComponent';

export default Scene.extend({
  willRender() {
    this.get('navigation').addListener('world.connect', this);
  },
  didRender() {
    console.log(this);
  },
  eKey() {
    console.log('enter realm');
  },
  willDestroy() {
    this.get('navigation').unsubscribe('world.connect');
  }
});
