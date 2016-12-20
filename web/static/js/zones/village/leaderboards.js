import State from '../base';



export default {
  cls: class VillageLeaderboardState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
    }

    load() {
      Mousetrap.bind(['space'], (e) => {
        this.spaceKeyPressed(e);
      });
      Mousetrap.bind(['enter'], (e) => {
        this.spaceKeyPressed(e);
      });
      Mousetrap.bind('r', (e) => {
        this.spaceKeyPressed(e);
      });
    }

    spaceKeyPressed(e) {
      this.game.handle_out('game.zone.village.loiter', 'village');
    }

    handle_in() {}
  },
  id: 'village.leaderboards'
}
