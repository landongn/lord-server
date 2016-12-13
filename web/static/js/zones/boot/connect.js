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
        console.log('boot.connect, in: ', payload);
      }

      load() {
        setTimeout(() => {
          // this.game.audio.play('thunder1');
          // this.game.audio.play(`crow0${Math.floor(Math.random() * 4) + 1}`);
        }, Math.floor(Math.random() * 2000) + 1000);
        Mousetrap.bind('enter', () => {
          this.game.handle_out('game.client.world.news', 'world');
        });
      }

    },

    id: 'boot.connect'
}