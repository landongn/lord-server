import State from '../../base';



export default {
  cls: class InnBartenderGemConfirmState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
    }

    rKeyPressed() {
      this.game.handle_out('game.zone.village.inn.bartender.gems.red.buy', 'village');
    }

    gKeyPressed() {
      this.game.handle_out('game.zone.village.inn.bartender.gems.green.buy', 'village');
    }

    bKeyPressed() {
      this.game.handle_out('game.zone.village.inn.bartender.gems.blue.buy', 'village');
    }

    rKeyPressed() {
      this.game.handle_out('game.zone.village.inn.loiter', 'village');
    }

  },
  id: 'game.zone.village.inn.bartender.gems.confirm'
}
