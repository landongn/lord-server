import State from 'web/static/js/zones/base';


export default {
  cls: class HealerHealFullState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
    }
    load() {}

    spaceKeyPressed() {
      this.game.handle_out('game.zone.village.loiter', 'village');
    }

    handle_in(payload) {
      console.log('healer in: ', payload);
      Mousetrap.bind(['enter', 'space'], (e) => {
        this.spaceKeyPressed(e);
      });
    }
  },
  id: 'village.healer.heal-full'
}