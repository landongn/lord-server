import State from 'web/static/js/zones/base';


export default {
  cls: class ForestLoiterState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
    }
    load() {

    }

    lKeyPressed() {
      this.game.handle_out('game.zone.forest.search', 'forest');
    }

    hKeyPressed() {
      this.game.handle_out('game.zone.healer.loiter', 'village');
    }

    rKeyPressed() {
      this.game.handle_out('game.zone.village.loiter', 'village');
    }

    handle_in(payload) {

      switch(payload.opcode) {
        case 'game.zone.forest.loiter':
          for (var i = payload.actions.length - 1; i >= 0; i--) {
            Mousetrap.unbind(payload.actions[i]);
            Mousetrap.bind(payload.actions[i], (e) => {
              const fn = `${e.key}KeyPressed`;
              this[fn] && this[fn]();
            });
          }
          break;

        default:
          console.log('unbound forest state', payload.opcode);
          break;
      }
    }
  },
  id: 'forest.loiter'
}