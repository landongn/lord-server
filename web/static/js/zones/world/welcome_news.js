import State from '../base';


export default {
    cls: class WelcomeNewsState extends State {
      constructor(game, id) {
        super(game, id);
        this.game = game;
        this.id = id;
      }

      handle_in(payload) {}

      load() {
        Mousetrap.bind('space', () => {
          this.game.handle_out('game.zone.character.select', 'character');
        });
      }

    },

    id: 'game.zone.world.news'
}
