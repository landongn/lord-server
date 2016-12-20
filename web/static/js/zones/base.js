export default class State {
  constructor(game, id) {
    this.game = game;
    this.id = id;
  }
  focus() {}
  load() {}

  bindKeys(payload) {
    const self = this;
    const actions = payload.actions;
    for (var i = 0; i < actions.length; i++) {
      const action = payload.actions[i];
      Mousetrap.bind(action, (e) => {
        const fn = `${action}KeyPressed`;
        self[fn]();
      });
    }
  }
  unload() {
    Mousetrap.reset();
    this.game.audio.fadeOut();
  }
}