import State from '../../base';



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
      const self = this;
      const actions = payload.actions;
      for (var i = 0; i < actions.length; i++) {
        const action = payload.actions[i];
        console.log('bound handler for ', `${action}KeyPressed`, action);
        Mousetrap.bind(action, (e) => {
          const fn = `${action}KeyPressed`;
          self[fn]();
        });
      }
    }
  },
  id: 'game.zone.village.healer.loiter'
}
