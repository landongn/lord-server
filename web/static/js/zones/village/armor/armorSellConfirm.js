
import State from '../../base';



export default {
  cls: class ArmorSellConfirmState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
    }

    nKeyPressed() {
      this.game.handle_out('game.zone.village.armor.loiter', 'village');
    }

    cKeyPressed() {
      this.game.handle_out('game.zone.village.armor.loiter', 'village');
    }

  },
  id: 'game.zone.village.armor.sell.confirm'
}
