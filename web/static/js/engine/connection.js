import {Socket} from 'phoenix';

export default class Connection {
  constructor(game) {
    this.game = game;
    this.socket = new Socket('/socket');
    this.socket.connect();
    this.channels = {};
    this.channels['world'] = this.socket.channel('world:system', {});
    this.channels['world'].join()
      .receive('ok', resp => {
        this.game.handle_in(resp, true);
      });

    this.channels['world'].on('msg', resp => {
      this.game.handle_in(resp, true);
    });
  }
}