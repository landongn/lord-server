import State from '../../zones/base';
import Mousetrap from '../../../vendor/Mousetrap';
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

        this.game.audio.play('rainloop', true);
        setTimeout(() => {
          this.game.audio.play('wolf_howl');
        }, 1000);
        setTimeout(() => {
          this.game.audio.play('thunder1');
        }, 300);
        Mousetrap.bind('enter', () => {
          this.game.handle_out('ident', 'world');
        });
      }

    },

    id: 'boot.connect'
}