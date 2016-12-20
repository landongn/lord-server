
import State from '../base';



export default {
  cls: class PlayersOnlineState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
    }



  },
  id: 'village.players.online'
}
