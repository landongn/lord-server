import State from 'web/static/js/zones/base';

export default {
    cls: class ConnectState extends State {
      constructor(game, id) {
        super(game, id);
        this.game = game;
        this.id = id;
        this.hasIdent = false;
      }

      handle_in(payload) {

      }

      load() {
        Mousetrap.bind('enter', () => {
          this.game.handle_out('game.client.world.news', 'world');
        });
        Mousetrap.bind('e', () => {
          this.game.handle_out('game.client.world.news', 'world');
        });
        Mousetrap.bind('i', () => {
          this.game.handle_out('game.client.world.instructions', 'world');
        });
        Mousetrap.bind('l', () => {
          this.game.handle_out('game.client.world.leaderboards', 'world');
        });
        Mousetrap.bind('space', () => {
          this.game.handle_out('game.client.world.news', 'world');
        });

      }

    },

    id: 'game.client.connect'
}
