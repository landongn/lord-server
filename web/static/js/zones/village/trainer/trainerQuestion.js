import State from '../../base';



export default {
  cls: class TrainerTalkState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
    }

    spaceKeyPressed() {
      this.game.handle_out('game.zone.village.trainer.loiter', 'village');
    }

    handle_in() {}
  },
  id: 'game.zone.village.trainer.question'
}
