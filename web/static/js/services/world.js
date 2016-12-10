import ConnectState from 'web/static/js/zones/boot/connect';
import IdentState from 'web/static/js/zones/boot/ident';
import CharacterSelectState from 'web/static/js/zones/character/select';
import CharacterCreateState from 'web/static/js/zones/character/create';
import CharacterListState from 'web/static/js/zones/character/list';
import CharacterValidateState from 'web/static/js/zones/character/validate';
import CharacterDeleteState from 'web/static/js/zones/character/delete';
import VillageLoiterState from 'web/static/js/zones/village/loiter';


export default class World {
  constructor(game) {
    this.game = game;
    this.zones = {
      [ConnectState.id]: new ConnectState.cls(game, ConnectState.id),
      [IdentState.id]: new IdentState.cls(game, IdentState.id),
      [CharacterSelectState.id]: new CharacterSelectState.cls(game, CharacterSelectState.id),
      [CharacterCreateState.id]: new CharacterCreateState.cls(game, CharacterCreateState.id),
      [CharacterListState.id]: new CharacterListState.cls(game, CharacterListState.id),
      [CharacterValidateState.id]: new CharacterValidateState.cls(game, CharacterValidateState.id),
      [CharacterDeleteState.id]: new CharacterDeleteState.cls(game, CharacterDeleteState.id),
      [VillageLoiterState.id]: new VillageLoiterState.cls(game, VillageLoiterState.id)
    };
    this.zone = null;

  }

  update(payload) {
    console.log("world:update", payload);
  }

  changeState(zone = {}) {
    console.log("changing state to : ", zone);
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

      case 'game.zone.character.new':
        this.changeState(CharacterCreateState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.zone.character.list':
        this.changeState(CharacterListState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.zone.character.confirm':
        this.changeState(CharacterValidateState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.zone.character.delete':
        this.changeState(CharacterDeleteState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.zone.village.loiter':
        this.changeState(VillageLoiterState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      default:
        this.zone && this.zone.handle_in(payload);
        return payload.message;
        break;
    }
  }

}