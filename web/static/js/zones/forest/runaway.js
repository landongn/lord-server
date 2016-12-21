import State from '../base';



export default {
  cls: class ForestFightState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
    }

    spaceKeyPressed() {
      this.game.handle_out('game.zone.forest.loiter', 'forest');
    }
  },
  id: 'game.zone.forest.run-away'
}
