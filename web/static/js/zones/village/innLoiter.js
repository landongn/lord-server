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

    spaceKeyPressed(e) {
      this.game.handle_out('game.zone.village.loiter', 'village');
    }

    handle_in() {
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
    }
  },
  id: 'village.inn.loiter'
}