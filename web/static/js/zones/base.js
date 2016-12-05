

export default class State {
  constructor(game) {
    this.states = {};
    this.game = game;

    this.game.requestInput(this);
  }

}