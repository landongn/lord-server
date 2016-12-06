import State from 'web/static/js/zones/base';

export default {
    cls: class ConnectState extends State {
      constructor(game, id) {
        super();
        this.game = game;
        this.id = id;
        this.hasIdent = false;
      }

      handle_in(payload) {
        console.log('boot.connect, in: ', payload);
      }

      load() {
        Mousetrap.bind('enter', (e) => {
          this.game.handle_out('ident', 'world');
        });
        this.game.gui.handleTouchesFor(['enter']);
      }

    },

    id: 'boot.connect'
}