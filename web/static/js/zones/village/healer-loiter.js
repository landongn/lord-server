import State from 'web/static/js/zones/base';


export default {
  cls: class HealerLoiterState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
    }
    load() {}

    hKeyPressed() {
      this.game.handle_out('game.zone.village.healer.heal-all', 'village', {id: this.game.character.id});
    }

    aKeyPressed() {
      this.game.handle_out('game.zone.village.healer.heal-all', 'village', {id: this.game.character.id});
    }

    rKeyPressed() {
      this.game.handle_out("game.zone.village.loiter", 'village');
    }

    handle_in(payload) {

      switch(payload.opcode) {
        case 'game.zone.village.healer.loiter':
          for (var i = payload.actions.length - 1; i >= 0; i--) {
            Mousetrap.unbind(payload.actions[i]);
            Mousetrap.bind(payload.actions[i], (e) => {
              const fn = `${e.key}KeyPressed`;
              this[fn] && this[fn]();
            });
          }
      }
    }
  },
  id: 'village.healer.loiter'
}