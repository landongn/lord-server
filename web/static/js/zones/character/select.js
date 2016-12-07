import State from 'web/static/js/zones/base';

export default {
  cls: class CharacterCreate extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
    }
    load() {
      console.log('character select');
    }
    handle_in(payload) {

    }
  }
}