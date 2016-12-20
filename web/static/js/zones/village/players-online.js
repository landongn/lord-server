
import State from '../base';



export default {
  cls: class PlayersOnlineState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
    }



  },
  id: 'game.zone.village.players.online'
}
