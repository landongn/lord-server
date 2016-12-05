export default class World {
  constructor(game) {
    this.game = game;
  }

  /* SERIOUS DRAGONS EXIST BELOW */
  event(payload) {

    switch (payload.opcode) {
      case 'game.client.connect':
        this.game.gui(payload);
        return payload.message;

      default:
        break;
    }
  }

}