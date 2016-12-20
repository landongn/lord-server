import State from '../base';


export default {
    cls: class WorldLeaderboardState extends State {
      constructor(game, id) {
        super(game, id);
        this.game = game;
        this.id = id;
      }

      spaceKeyPressed() {
        this.game.handle_out('game.client.world.news', 'world');
      }
      rKeyPressed() {
        this.game.handle_out('game.client.world.connect', 'world');
      }
      enterKeyPressed() {
        this.game.handle_out('game.client.world.news', 'world');
      }

    },

    id: 'game.zone.world.leaderboards'
}
