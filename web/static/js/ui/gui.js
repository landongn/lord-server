import Chatbox from './chat';

export default class Gui {
  constructor(game) {
    this.game = game;
    this.chatbox = new Chatbox(this, game);
    this.touchenabled = false;
    this.logEl = document.getElementById('log');
    // this.touchBarEl = document.getElementById('touchBar');
    // this.touchBarEl.style.visibility = 'hidden';
    this.targets = [];
  }

  handle_in(payload) {
    switch(payload.opcode) {
      case 'game.zone.broadcast':
        this.chatbox.render(payload);
        break;

      default:
        break;
    }
  }

  toggleChat() {
    this.chatbox.toggleVisibility();
  }

  status(payload) {

  }
}
