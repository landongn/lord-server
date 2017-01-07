export BUTTONS = {
  FORWARD: 'w';
}

export default class Input {
  constructor() {

  }

  hook(event_name, callback) {
    window.removeEventListener(event_name);
    window.addEventListener(event_name, callback);
  }

  unhook(event_name) {
    window.removeEventListener(event_name);
  }
}
