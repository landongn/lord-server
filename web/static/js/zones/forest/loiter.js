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
      this.game.handle_out('game.zone.forest.search', 'forest', {id: this.game.character.id, level: this.game.character.level});
    }

    hKeyPressed() {
      this.game.handle_out('game.zone.village.healer.loiter', 'village');
    }

    vKeyPressed() {
      this.game.handle_out("game.zone.forest.stats", 'forest', {id: this.game.character.id});
    }

    rKeyPressed() {
      this.game.handle_out('game.zone.village.loiter', 'village');
    }

    handle_in(payload) {
      const actions = payload.actions;
      for (var i = 0; i < actions.length; i++) {
        Mousetrap.bind(actions[i], (e) => {
          const fn = `${e.key}KeyPressed`;
          this[fn] && this[fn]();
        });
      }
    }
  },
  id: 'forest.loiter'
}