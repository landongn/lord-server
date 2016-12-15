import Chatbox from 'web/static/js/ui/chat';

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



  toggleChat() {
    this.chatbox.toggleVisibility();
  }

  status(payload) {

  }
}