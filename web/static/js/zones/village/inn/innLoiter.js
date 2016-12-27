import State from '../../base';



export default {
  cls: class InnLoiterState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
    }

    load() {

    }

    fKeyPressed(e) {
      this.game.handle_out('game.zone.village.inn.violet', 'village');
    }

    tKeyPressed(e) {
      this.game.handle_out('game.zone.village.inn.bartender', 'village');
    }

    cKeyPressed(e) {
      this.game.handle_out('game.zone.village.inn.messageboard', 'village');
    }

    dKeyPressed(e) {
      this.game.handle_out('game.zone.village.inn.news', 'village');
    }

    gKeyPressed(e) {
      this.game.handle_out('game.zone.village.inn.room.ask', 'village');
    }

    hKeyPressed(e) {
      this.game.handle_out('game.zone.village.inn.bard', 'village');
    }

    vKeyPressed(e) {
      this.game.handle_out('game.zone.village.stats', 'village');
    }

    rKeyPressed(e) {
      this.game.handle_out('game.zone.village.loiter', 'village');
    }

    handle_in(payload) {
      const self = this;
      const actions = payload.actions;
      for (var i = 0; i < actions.length; i++) {
        const action = payload.actions[i];
        Mousetrap.bind(action, (e) => {
          const fn = `${action}KeyPressed`;
          self[fn]();
        });
      }
    }
  },
  id: 'game.zone.village.inn.loiter'
}
