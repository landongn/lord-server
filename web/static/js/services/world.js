import ConnectState from 'web/static/js/zones/boot/connect';


export default class World {
  constructor(game) {
    this.game = game;
    this.zones = {
      [ConnectState.id]: new ConnectState.cls(game, ConnectState.id)
    };
    this.activeZoneId = null;

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

    switch (payload.opcode) {
      case 'game.client.connect':
        this.game.gui.status(payload);
        this.changeState(ConnectState);
        return payload.message;

      case 'game.client.ident-challenge':
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.client.ident-email':
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      default:
        break;
    }
  }

}