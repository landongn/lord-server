import State from '../../base';



export default {
  cls: class TrainerChallengeState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
    }

    dKeyPressed() {
      this.game.handle_out('game.zone.village.trainer.loiter', 'village');
    }

    rKeyPressed() {
      this.game.handle_out('game.zone.village.trainer.loiter', 'village');
    }

    aKeyPressed() {
      this.game.handle_out('game.zone.village.trainer.fight', 'village');
    }

    handle_in() {}
  },
  id: 'game.zone.village.trainer.challenge'
}
