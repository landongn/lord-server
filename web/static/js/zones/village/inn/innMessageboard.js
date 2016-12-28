import State from '../../base';



export default {
  cls: class InnForumState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
      this.pageIndex = 0;
    }

    wKeyPressed() {
      this.game.handle_out("game.zone.village.inn.messageboard.write", "village");
    }

    nKeyPressed() {
      this.game.handle_out("game.zone.village.inn.messageboard.page", "village", {page: ++this.pageIndex});
    }

    rKeyPressed() {
      this.game.handle_out("game.zone.village.inn.loiter", "village");
    }

  },
  id: 'game.zone.village.inn.messageboard'
}
