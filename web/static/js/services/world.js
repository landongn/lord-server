import ConnectState from 'web/static/js/zones/boot/connect';


export default class World {
  constructor(game) {
    this.game = game;
    this.zones = {};
    this.activeZoneId = null;

  }

  changeState(zone = {}) {
      this.game.renderer.clear();
      if (this.zones[zone.id]) {
          this.zone = this.zones[zone.id];
      }
  }

  /* SERIOUS DRAGONS EXIST BELOW */
  event(payload) {

    switch (payload.opcode) {
      case 'game.client.connect':
        this.game.gui.status(payload);
        this.changeState(ConnectState);
        return payload.message;

      default:
        break;
    }
  }

}