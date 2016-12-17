import State from 'web/static/js/zones/base';


export default {
  cls: class WeaponsBuyState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
      this.equipment = null;
    }

    load() {
      Mousetrap.bind('b', (e) => {
        this.game.handle_out('game.zone.village.weapons.buy', 'village');
      });

      Mousetrap.bind('s', (e) => {
        this.game.handle_out('game.zone.village.weapons.sell.offer', 'village');
      });

      Mousetrap.bind('r', (e) => {
        this.game.handle_out('game.zone.village.loiter', 'village');
      });
    }

    selectWeapon(i) {
      const wep = this.equipment[i];
      this.game.handle_out('game.zone.village.weapons.purchase', 'village', {weapon: wep});
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
  id: 'village.weapons.buy'
}