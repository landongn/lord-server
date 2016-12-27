import State from '../../base';



export default {
  cls: class InnBartenderGemDoneState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
    }

    spaceKeyPressed() {
      this.game.handle_out('game.zone.village.inn.loiter', 'village');
    }

    enterKeyPressed() {
      this.game.handle_out('game.zone.village.inn.loiter', 'village');
    }

  },
  id: 'game.zone.village.inn.bartender.gem.done'
}
