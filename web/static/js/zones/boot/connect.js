import State from 'web/static/js/zones/base';

export default {
    cls: class ConnectState extends State {
      constructor(game, id) {
        super();
        this.game = game;
        this.id = id;
        this.actions = {};
      }

      handle_in(payload) {

      }

      load() {
        this.game.requestInput(this);
      }

      keypress(key, event) {
        if (key === 'enter') {
            this.game.handle_out('ident', 'world');
        }

        if (key === 'e') {
            this.game.handle_out('email-ident', 'world');
        }
      }
    },

    id: 'boot.connect'
}