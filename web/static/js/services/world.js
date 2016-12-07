import ConnectState from 'web/static/js/zones/boot/connect';
import IdentState from 'web/static/js/zones/boot/ident';
import VillageLoiterState from 'web/static/js/zones/village/loiter';
import CharacterSelectState from 'web/static/js/zones/character/select';



export default class World {
  constructor(game) {
    this.game = game;
    this.zones = {
      [ConnectState.id]: new ConnectState.cls(game, ConnectState.id),
      [IdentState.id]: new IdentState.cls(game, IdentState.id),
      [VillageLoiterState.id]: new VillageLoiterState.cls(game, VillageLoiterState.id),
      [CharacterSelectState.id]: new CharacterSelectState.cls(game, CharacterSelectState.id)
    };
    this.zone = null;

  }

  update(payload) {
    console.log("world:update", payload);
  }

  changeState(zone = {}) {
      this.game.renderer.clear();

      if (this.zone) {
        this.zone.unload();
      }

      if (this.zones[zone.id || zone]) {
          this.zone = this.zones[zone.id || zone];
          this.zone.load();
      }
  }

  /* SERIOUS DRAGONS EXIST BELOW */
  event(payload) {
    console.log("socket in: ", payload.opcode);
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

      case 'game.zone.character.select':
        this.changeState(CharacterSelectState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      default:
        this.zone && this.zone.handle_in(payload);
        return payload.message;
        break;
    }
  }

}