import State from '../../base';



export default {
  cls: class WeaponPurchaseState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
    }

    load() {
      Mousetrap.bind(['space', 'enter'], (e) => {
        this.spaceKeyPressed(e);
      });
    }

    spaceKeyPressed(e) {
      this.game.handle_out('game.zone.village.loiter', 'village');
    }

    handle_in() {}
  },
  id: 'game.zone.village.weapons.purchase'
}
