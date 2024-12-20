import State from '../../base';



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
      this.game.handle_out('game.zone.village.weapons.purchase', 'village', {weapon_id: wep.id});
    }

    handle_in(payload) {
      const equipment = payload.equipment;
      this.equipment = payload.equipment;
      for (let i = 0; i < equipment.length; i++) {
        const key = i+1+'';
        const it = i;
        Mousetrap.bind(key, (e) => {
          this.selectWeapon(i);
        });
      }
    }
  },
  id: 'game.zone.village.weapons.buy'
}
