import Mousetrap from '../../vendor/Mousetrap';

export default class State {
  constructor(game, id) {
    this.game = game;
    this.id = id;
  }
  resignResponder() {}
  focus() {}
  load() {

  }
  unload() {
    Mousetrap.reset();
    // this.game.gui.resetTouches();
    this.game.audio.fadeOut();
  }
}