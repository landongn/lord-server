import State from 'web/static/js/zones/base';

export default {
  cls: class VillageLoiterState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
    }
    load() {}
    handle_in(payload) {

    }
  }
}