
import State from '../../base';



export default {
  cls: class ArmorSellConfirmState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
    }
    load() {

    }

    out(place) {
      this.game.handle_out(`game.zone.village.${place}`, 'village');
    }

    handle_in(payload) {
      switch(payload.opcode) {
        case 'game.zone.village.armor.sell.offer':
          for (var i = payload.actions.length - 1; i >= 0; i--) {
            Mousetrap.unbind(payload.actions[i]);
            Mousetrap.bind(payload.actions[i], () => {
              this[payload.actions[i] + 'KeyPressed'] && this[payload.actions[i] + 'KeyPressed']();
            });
          }
      }
    }
  },
  id: 'game.zone.village.armor.sell.offer'
}
