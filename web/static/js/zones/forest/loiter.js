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

    out(place) {
      console.log('out to', place);
      this.game.handle_out(`game.zone.forest.${place}`, 'forest');
    }

    lKeyPressed() {
      this.out('search');
    }

    hKeyPressed() {
      this.out('healer.loiter')
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