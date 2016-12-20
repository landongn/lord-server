import State from '../base';



export default {
  cls: class ArmorLoiterState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
    }

    bKeyPressed() {
      this.game.handle_out('game.zone.village.armor.buy', 'village');
    }

    sKeyPressed() {
      this.game.handle_out('game.zone.village.armor.sell.offer', 'village');
    }

    rKeyPressed() {
      this.game.handle_out('game.zone.village.loiter', 'village');
    }

    handle_in() {}
  },
  id: 'game.zone.village.armor.loiter'
}
