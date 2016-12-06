import BaseState from 'web/static/js/zones/base';

export default {
    cls: class WelcomeState extends BaseState {
      constructor(game, id) {
        super();
        this.game = game;
        this.id = id;
      }

      handle_in(payload) {
        console.log('welcome screen!');
      }
      load() {
        Mousetrap.bind('p', (e) => {
          this.game.world.changeState('world.village.loiter');
        });
      }
    },
  id: 'boot.welcome'
};