export default class State {
  constructor() {}
  resignResponder() {}
  focus() {}
  load() {

  }
  unload() {
    Mousetrap.reset();
    // this.game.gui.resetTouches();
  }
}