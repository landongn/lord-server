import State from '../../base';



export default {
  cls: class TrainerLoiterState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
    }

    qKeyPressed() {
      this.game.handle_out('game.zone.village.trainer.question', 'village');
    }
    cKeyPressed() {
      console.log('fuckeofiasdofijadf');
      this.game.handle_out('game.zone.village.trainer.challenge', 'village');
    }
    rKeyPressed() {
      this.game.handle_out('game.zone.village.loiter', 'village');
    }
  },
  id: 'game.zone.village.trainer.loiter'
}
