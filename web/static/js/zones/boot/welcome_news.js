import State from 'web/static/js/zones/base';

export default {
    cls: class WelcomeNewsState extends State {
      constructor(game, id) {
        super(game, id);
        this.game = game;
        this.id = id;
      }


      load() {
        Mousetrap.bind('space', () => {
          this.game.handle_out('game.zone.character.select', 'character');
        });
      }

    },

    id: 'boot.news'
}