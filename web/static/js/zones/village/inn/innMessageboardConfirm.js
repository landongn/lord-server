import State from '../../base';



export default {
  cls: class InnMessageBoardWriteState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
    }

    spaceKeyPressed () {
      this.game.handle_out("game.zone.village.inn.loiter", "village");
    }

    returnKeyPressed() {
      this.game.handle_out("game.zone.village.inn.loiter", "village");
    }

  },
  id: 'game.zone.village.inn.messageboard.save'
}
