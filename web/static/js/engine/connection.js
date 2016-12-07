import {Socket} from 'phoenix';

export default class Connection {
  constructor(game) {
    this.game = game;
    this.socket = new Socket('/socket', {params: {token: window.zlordtoken}});
    this.socket.connect();
    this.channels = {};
    this.channels['world'] = this.socket.channel('world:system', {});
    this.channels['zone'] = this.socket.channel('zone', {});
    this.channels['character'] = this.socket.channel('character', {});
    this.channels['forest'] = this.socket.channel('forest', {});
    this.channels['village'] = this.socket.channel('village', {});
    this.channels['messaging'] = this.socket.channel('messaging', {});

    const channels = Object.keys(this.channels);
    for (var i = 0; i < channels.length; i++) {
      this.channels[channels[i]].join()
        .receive('ok', resp => {
          this.game.handle_in(resp, true);
        });

      this.channels[channels[i]].on('msg', resp => {
        this.game.handle_in(resp, true);
      });

      this.channels[channels[i]].on('data', resp => {
        console.log("updating ", this.channels[channels[i]], resp);
        this.game.update(resp.system, resp);
      });
    }
  }
}