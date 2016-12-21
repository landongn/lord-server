import State from '../../base';



export default {
  cls: class TrainerWinState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
    }

    spaceKeyPressed(e) {
      this.game.handle_out('game.zone.village.loiter', 'village');
    }

    handle_in() {}
  },
  id: 'game.zone.village.trainer.win'
}
