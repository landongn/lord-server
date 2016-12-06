import ConnectState from 'web/static/js/zones/boot/connect';
import IdentState from 'web/static/js/zones/boot/ident';


export default class World {
  constructor(game) {
    this.game = game;
    this.zones = {
      [ConnectState.id]: new ConnectState.cls(game, ConnectState.id),
      [IdentState.id]: new IdentState.cls(game, IdentState.id)
    };
    this.zone = null;

  }

  changeState(zone = {}) {
      this.game.renderer.clear();

      if (this.zone) {
        this.zone.unload();
      }

      if (this.zones[zone.id]) {
          this.zone = this.zones[zone.id];
          this.zone.load();
      }
  }

  /* SERIOUS DRAGONS EXIST BELOW */
  event(payload) {
    console.log("socket in: ", payload);
    switch (payload.opcode) {
      case 'game.client.connect':
        this.game.gui.status(payload);
        this.game.handle_out('motd', 'world');
        return payload.message;

      case 'game.client.motd':
        this.changeState(ConnectState);
        return payload.message;

      case 'game.client.ident-challenge':
      this.changeState(IdentState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.client.ident-email':
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.client.ident.notfound':
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.client.ident.success':
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      default:
        console.info('unhandled opcode: ', payload.opcode);
        break;
    }
  }

}