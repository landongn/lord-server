import State from 'web/static/js/zones/base';


export default {
  cls: class WeaponsLoiterState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
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

    handle_in() {}
  },
  id: 'village.weapons.loiter'
}