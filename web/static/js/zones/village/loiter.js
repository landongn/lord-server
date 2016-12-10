import State from 'web/static/js/zones/base';

export default {
  cls: class VillageLoiterState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
    }
    load() {
      console.log('loitering in the village');
    }

    iKeyPressed() {
      this.game.handle_out('game.zone.village.inn.loiter', 'village');
    }

    kKeyPressed() {
      this.game.handle_out('game.zone.village.weapons.loiter', 'village');
    }

    hKeyPressed() {
      this.game.handle_out('game.zone.village.healer.loiter', 'village');
    }

    handle_in(payload) {
      debugger;
      switch(payload.opcode) {
        case 'game.zone.village.loiter':
          for (var i = payload.actions.length - 1; i >= 0; i--) {
            Mousetrap.unbind(payload.actions[i]);
            Mousetrap.bind(payload.actions[i], () => {
              this[payload.actions[i] + 'keyPressed'] && this[payload.actions[i] + 'keyPressed']();
            });
          }
      }
    }
  },
  id: 'village.loiter'
}