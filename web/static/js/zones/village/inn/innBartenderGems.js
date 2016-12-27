import State from '../../base';



export default {
  cls: class InnBartenderGemState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
    }

    rKeyPressed() {
      this.game.handle_out('game.zone.village.inn.bartender.gem-purchase', 'village', {gemtype: "red"});
    }

    gKeyPressed() {
      this.game.handle_out('game.zone.village.inn.bartender.gem-purchase', 'village', {gemtype: "green"});
    }

    bKeyPressed() {
      this.game.handle_out('game.zone.village.inn.bartender.gem-purchase', 'village', {gemtype: "blue"});
    }

    nKeyPressed() {
      this.game.handle_out('game.zone.village.inn.bartender.loiter', 'village');
    }

  },
  id: 'game.zone.village.inn.bartender.gems'
}
