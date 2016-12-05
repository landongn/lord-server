

export default class State {
  constructor() {
    // override me with keyCodes that I can respond to
    this.actions = {};
    this.name = '';
    this.attach();
  }

}