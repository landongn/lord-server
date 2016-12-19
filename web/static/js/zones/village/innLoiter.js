import State from 'web/static/js/zones/base';


export default {
  cls: class InnLoiterState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
    }

    load() {

    }

    fKeyPressed(e) {}
    tKeyPressed(e) {}
    cKeyPressed(e) {}
    dKeyPressed(e) {}
    gKeyPressed(e) {}
    hKeyPressed(e) {}
    vKeyPressed(e) {}

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
  id: 'village.inn.loiter'
}
