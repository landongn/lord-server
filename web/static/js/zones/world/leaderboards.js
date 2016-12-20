import State from '../base';


export default {
    cls: class WorldLeaderboardState extends State {
      constructor(game, id) {
        super(game, id);
        this.game = game;
        this.id = id;
      }

      spaceKeyPressed() {
        this.game.handle_out('game.zone.character.select', 'character');
      }

    },

    id: 'game.zone.world.leaderboards'
}
