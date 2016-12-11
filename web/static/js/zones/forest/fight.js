import State from 'web/static/js/zones/base';


export default {
  cls: class ForestFightState extends State {
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

    aKeyPressed() {
      this.out('forest.attack');
    }

    pKeyPressed() {
      this.out('forest.power-move')
    }

    rKeyPressed() {
      this.out('forest.run-away')
    }

    handle_in(payload) {

      switch(payload.opcode) {
        case 'game.zone.forest.engage':
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
  id: 'forest.fight'
}