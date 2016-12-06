import Chatbox from 'web/static/js/ui/chat';

export default class Gui {
  constructor(game) {
    this.game = game;
    this.chatbox = new Chatbox(this);
    this.touchenabled = false;
    this.logEl = document.getElementById('log');
    this.touchBarEl = document.getElementById('touchBar');
    this.targets = [];
  }

  handleTouchesFor(commands) {
    for (var i = commands.length - 1; i >= 0; i--) {
      this.game.renderer.render({message: `<li class="touch-command">${commands[i]}</li>`});
      const el = document.querySelectorAll('.touch-command:last-child');
      el.addEventListener('touchstart', (e) => {
        this.reconfigureForTouch();
        this.touchstart(e, command[i]);
      });

      el.addEventListener('touchend', (e) => {
        this.touchend(e, command[i]);
      });
      this.targets.push(el);
    }
  }

  touchstart(e, command) {
    Mousetrap.trigger(command);
  }
  touchend(e, command) {
    Mousetrap.trigger(command);
  }

  reconfigureForTouch() {
    this.logEl.classList.add('touch');
    this.touchBarEl.classList.add('active');
  }

  toggleChat() {
    this.chatbox.toggleVisibility();
  }

  status(payload) {

  }
}