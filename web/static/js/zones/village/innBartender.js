import State from '../base';



export default {
  cls: class InnBartenderState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
    }

    vKeyPressed() {
      this.game.handle_out('game.zone.village.inn.bartender.violet', 'village');
    }

    gKeyPressed() {
      this.game.handle_out('game.zone.village.inn.bartender.gems', 'village');
    }

    bKeyPressed() {
      this.game.handle_out('game.zone.village.inn.bartender.bribe', 'village');
    }

    rKeyPressed() {
      this.game.handle_out('game.zone.village.inn.loiter', 'village');
    }

    spaceKeyPressed(e) {
      this.game.handle_out('game.zone.village.loiter', 'village');
    }

    handle_in() {}
  },
  id: 'game.zone.village.inn.bartender'
}
