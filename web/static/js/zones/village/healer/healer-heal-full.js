import State from '../../base';



export default {
  cls: class HealerHealFullState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
    }
    load() {}

    spaceKeyPressed() {
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
  id: 'game.zone.village.healer.heal-full'
}
