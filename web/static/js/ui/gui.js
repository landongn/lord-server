import Chatbox from 'web/static/js/ui/chat';

export default class Gui {
  constructor(game) {
    this.game = game;
    this.chatbox = new Chatbox(this);
  }

  toggleChat() {
    this.chatbox.toggleVisibility();
  }

  status(payload) {
    
  }
}