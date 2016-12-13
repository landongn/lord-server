import State from 'web/static/js/zones/base';


export default {
  cls: class HealerHealSomeState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
    }
    load() {}

    spaceKeyPressed() {
      this.game.handle_out('game.zone.village.healer.loiter', 'village');
    }

    handle_in(payload) {

      switch(payload.opcode) {
        case 'game.zone.village.healer.heal-some':
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
  id: 'village.healer.heal-some'
}