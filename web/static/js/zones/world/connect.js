import State from '../base';


export default {
    cls: class ConnectState extends State {
      constructor(game, id) {
        super(game, id);
        this.game = game;
        this.id = id;
        this.hasIdent = false;
      }

      enterKeyPressed() {
        this.game.handle_out('game.client.world.news', 'world');
      }

      eKeyPressed() {
        this.game.handle_out('game.client.world.news', 'world');
      }
      iKeyPressed() {
        this.game.handle_out('game.client.world.instructions', 'world');
      }
      lKeyPressed() {
        this.game.handle_out('game.client.world.leaderboards', 'world');
      }
      spaceKeyPressed() {
        this.game.handle_out('game.client.world.news', 'world');
      }
    },

    id: 'game.client.connect'
}
