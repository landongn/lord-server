import State from '../base';


export default {
    cls: class WorldInstructionsState extends State {
      constructor(game, id) {
        super(game, id);
        this.game = game;
        this.id = id;
      }

      load() {}
      spaceKeyPressed() {
        this.game.handle_out('game.zone.world.news', 'world');
      }
    },

    id: 'game.client.world.instructions'
}
