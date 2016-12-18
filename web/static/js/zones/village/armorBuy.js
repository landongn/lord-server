import State from 'web/static/js/zones/base';


export default {
  cls: class ArmorBuyState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
      this.equipment = null;
    }

    load() {
      Mousetrap.bind('b', (e) => {
        this.game.handle_out('game.zone.village.armor.buy', 'village');
      });

      Mousetrap.bind('s', (e) => {
        this.game.handle_out('game.zone.village.armor.sell.offer', 'village');
      });

      Mousetrap.bind('r', (e) => {
        this.game.handle_out('game.zone.village.loiter', 'village');
      });
    }

    selectWeapon(i) {
      const armor = this.equipment[i];
      this.game.handle_out('game.zone.village.armor.purchase', 'village', {armor_id: armor.id});
    }

    handle_in(payload) {
      const equipment = payload.equipment;
      this.equipment = payload.equipment;
      for (let i = 0; i < equipment.length; i++) {
        const key = i+1+'';
        Mousetrap.bind(key, (e) => {
          this.selectWeapon(i-1);
        });
      }
    }
  },
  id: 'village.armor.buy'
}