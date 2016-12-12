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
      this.out('attack');
    }

    pKeyPressed() {
      this.out('power-move')
    }

    rKeyPressed() {
      this.out('run-away')
    }

    handle_in(payload) {

      switch(payload.opcode) {
        case 'game.zone.forest.fight':
          for (var i = payload.actions.length - 1; i >= 0; i--) {
            Mousetrap.unbind(payload.actions[i]);
            Mousetrap.bind(payload.actions[i], (e) => {
              const fn = `${e.key}KeyPressed`;
              this[fn] && this[fn]();
            });
          }
          console.log('fight start: ', payload);
          break;

        case 'game.zone.forest.round':
          console.log('game round: ', payload);
          this.game.audio.play(payload.fight.mob.s_hit);
          break;

        default:
          console.log('unbound forest state', payload.opcode);
          break;
      }
    }
  },
  id: 'forest.fight'
}