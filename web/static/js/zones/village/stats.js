import State from '../base';



export default {
  cls: class VillageStatsState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
    }

    load() {
    }
    rKeyPressed() {
      this.game.handle_out('game.zone.village.loiter', 'village');
    }
  },
  id: 'game.zone.village.stats'
}
