import ConnectState from 'web/static/js/zones/world/connect';
import WelcomeNewsState from 'web/static/js/zones/world/welcome_news';
import WorldLeaderboardState from 'web/static/js/zones/world/leaderboards';
import WorldInstructionsState from 'web/static/js/zones/world/instructions';

import CharacterSelectState from 'web/static/js/zones/character/select';
import CharacterCreateState from 'web/static/js/zones/character/create';
import CharacterListState from 'web/static/js/zones/character/list';
import CharacterValidateState from 'web/static/js/zones/character/validate';
import CharacterDeleteState from 'web/static/js/zones/character/delete';

import ArmorLoiterState from 'web/static/js/zones/village/armorLoiter';
import ArmorBuyState from 'web/static/js/zones/village/armorBuy';
import ArmorPurchaseState from 'web/static/js/zones/village/armorPurchase';
import ArmorSellConfirmState from 'web/static/js/zones/village/armorSellConfirm';
import ArmorSellOfferState from 'web/static/js/zones/village/armorSellOffer';

import InnBardState from 'web/static/js/zones/village/innBard';
import InnStatsState from 'web/static/js/zones/village/innStats';
import InnMessageboardState from 'web/static/js/zones/village/innMessageboard';
import InnNewsState from 'web/static/js/zones/village/innNews';
import InnBartenderState from 'web/static/js/zones/village/innBartender';
import InnLoiterState from 'web/static/js/zones/village/innLoiter';
import InnRoomAskState from 'web/static/js/zones/village/innRoomAsk';
import InnVioletState from 'web/static/js/zones/village/innViolet';
import InnRoomConfirmState from 'web/static/js/zones/village/inRoomConfirm';

import VillageLeaderboardState from 'web/static/js/zones/village/leaderboards';
import VillageNewsState from 'web/static/js/zones/village/news';
import VillagePlayersOnlineState from 'web/static/js/zones/village/players-online';
import VillageLoiterState from 'web/static/js/zones/village/loiter';

import TrainerChallengeState from 'web/static/js/zones/village/trainerChallenge';
import TrainerFailState from 'web/static/js/zones/village/trainerFail';
import TrainerLoiterState from 'web/static/js/zones/village/trainerLoiter';
import TrainerTalkState from 'web/static/js/zones/village/trainerTalk';

import WeaponsBuyState from 'web/static/js/zones/village/weaponsBuy';
import WeaponsLoiterState from 'web/static/js/zones/village/weaponsLoiter';
import WeaponsPurchaseState from 'web/static/js/zones/village/weaponsPurchase';
import WeaponsSellConfirmState from 'web/static/js/zones/village/weaponsSellConfirm';
import WeaponsSellOfferState from 'web/static/js/zones/village/weaponsSellOffer';

import HealerLoiterState from 'web/static/js/zones/village/healer-loiter';
import HealerHealAllState from 'web/static/js/zones/village/healer-heal-all';
import HealerHealFullState from 'web/static/js/zones/village/healer-heal-full';

import ForestLoiterState from 'web/static/js/zones/forest/loiter';
import ForestFightState from 'web/static/js/zones/forest/fight';

export default class World {
  constructor(game) {
    this.game = game;

    this.zones = {
      [ConnectState.id]: new ConnectState.cls(game, ConnectState.id),
      [WelcomeNewsState.id]: new WelcomeNewsState.cls(game, WelcomeNewsState.id),
      [WorldLeaderboardState.id]: new WorldLeaderboardState.cls(game, WorldLeaderboardState.id),
      [WorldInstructionsState.id]: new WorldInstructionsState.cls(game, WorldInstructionsState.id),

      [CharacterSelectState.id]: new CharacterSelectState.cls(game, CharacterSelectState.id),
      [CharacterCreateState.id]: new CharacterCreateState.cls(game, CharacterCreateState.id),
      [CharacterListState.id]: new CharacterListState.cls(game, CharacterListState.id),
      [CharacterValidateState.id]: new CharacterValidateState.cls(game, CharacterValidateState.id),
      [CharacterDeleteState.id]: new CharacterDeleteState.cls(game, CharacterDeleteState.id),

      [ArmorLoiterState.id]: new ArmorLoiterState.cls(game, ArmorLoiterState.id),
      [ArmorBuyState.id]: new ArmorBuyState.cls(game, ArmorBuyState.id),
      [ArmorPurchaseState.id]: new ArmorPurchaseState.cls(game, ArmorPurchaseState.id),
      [ArmorSellConfirmState.id]: new ArmorSellConfirmState.cls(game, ArmorSellConfirmState.id),
      [ArmorSellOfferState.id]: new ArmorSellOfferState.cls(game, ArmorSellOfferState.id),

      [InnBardState.id]: new InnBardState.cls(game, InnBardState.id),
      [InnStatsState.id]: new InnStatsState.cls(game, InnStatsState.id),
      [InnNewsState.id]: new InnNewsState.cls(game, InnNewsState.id),
      [InnMessageboardState.id]: new InnMessageboardState.cls(game, InnMessageboardState.id),
      [InnBartenderState.id]: new InnBartenderState.cls(game, InnBartenderState.id),
      [InnLoiterState.id]: new InnLoiterState.cls(game, InnLoiterState.id),
      [InnRoomAskState.id]: new InnRoomAskState.cls(game, InnRoomAskState.id),
      [InnVioletState.id]: new InnVioletState.cls(game, InnVioletState.id),
      [InnRoomConfirmState.id]: new InnRoomConfirmState.cls(game, InnRoomConfirmState.id),

      [VillageLeaderboardState.id]: new VillageLeaderboardState.cls(game, VillageLeaderboardState.id),
      [VillageNewsState.id]: new VillageNewsState.cls(game, VillageNewsState.id),
      [VillagePlayersOnlineState.id]: new VillagePlayersOnlineState.cls(game, VillagePlayersOnlineState.id),
      [VillageLoiterState.id]: new VillageLoiterState.cls(game, VillageLoiterState.id),

      [TrainerChallengeState.id]: new TrainerChallengeState.cls(game, TrainerChallengeState.id),
      [TrainerFailState.id]: new TrainerFailState.cls(game, TrainerFailState.id),
      [TrainerLoiterState.id]: new TrainerLoiterState.cls(game, TrainerLoiterState.id),
      [TrainerTalkState.id]: new TrainerTalkState.cls(game, TrainerTalkState.id),

      [WeaponsBuyState.id]: new WeaponsBuyState.cls(game, WeaponsBuyState.id),
      [WeaponsLoiterState.id]: new WeaponsLoiterState.cls(game, WeaponsLoiterState.id),
      [WeaponsPurchaseState.id]: new WeaponsPurchaseState.cls(game, WeaponsPurchaseState.id),
      [WeaponsSellConfirmState.id]: new WeaponsSellConfirmState.cls(game, WeaponsSellConfirmState.id),
      [WeaponsSellOfferState.id]: new WeaponsSellOfferState.cls(game, WeaponsSellOfferState.id),

      [HealerLoiterState.id]: new HealerLoiterState.cls(game, HealerLoiterState.id),
      [HealerHealAllState.id]: new HealerHealAllState.cls(game, HealerHealAllState.id),
      [HealerHealFullState.id]: new HealerHealFullState.cls(game, HealerHealFullState.id),

      [ForestLoiterState.id]: new ForestLoiterState.cls(game, ForestLoiterState.id),
      [ForestFightState.id]: new ForestFightState.cls(game, ForestFightState.id),
    };

    this.zone = null;

  }

  update(payload) {
  }

  changeState(zone_id) {
      this.game.renderer.clear();

      if (this.zone) {
        this.zone.unload();
      }

      if (this.zones[zone_id]) {
          this.zone = this.zones[zone_id];
          this.zone.load();
      }
  }

  event(payload) {
    if (this.zones[payload.opcode]) {
      this.changeState(payload.opcode);
      this.zone && this.zone.handle_in(payload);
      return payload.message;
    }
    return payload.message;
  }

  /* SERIOUS DRAGONS EXIST BELOW */
  event_old(payload) {
    switch (payload.opcode) {
      case 'game.client.connect':
        this.game.gui.status(payload);
        this.game.handle_out('motd', 'world');
        return payload.message;

      case 'game.client.motd':
        this.changeState(ConnectState);
        return payload.message;

      case 'game.zone.world.news':
        this.changeState(WelcomeNewsState);
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

      case 'game.zone.forest.loiter':
        this.changeState(ForestLoiterState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.zone.forest.fight':
        this.changeState(ForestFightState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      /* #### Village #### */
      case 'game.zone.village.loiter':
        this.changeState(VillageLoiterState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.zone.village.healer.loiter':
        this.changeState(HealerLoiterState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.zone.village.healer.heal-all':
        this.changeState(HealerHealAllState);
        this.game.audio.play('spelgdht');
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.zone.village.healer.heal-full':
        this.changeState(HealerHealAllState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.zone.village.armor.loiter':
        this.changeState(ArmorLoiterState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.zone.village.armor.buy':
        this.changeState(ArmorBuyState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.zone.village.armor.purchase':
        this.changeState(ArmorPurchaseState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.zone.village.armor.sell.confirm':
        this.changeState(ArmorSellConfirmState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.zone.village.armor.sell.offer':
        this.changeState(ArmorSellOfferState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      /* ### Inn ### */
      case 'game.zone.village.inn.loiter':
        this.changeState(InnLoiterState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.zone.village.inn.bard':
        this.changeState(InnBardState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.zone.village.inn.bartender':
        this.changeState(InnBartenderState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.zone.village.inn.loiter':
        this.changeState(InnLoiterState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.zone.village.inn.room.ask':
        this.changeState(InnRoomAskState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.zone.village.inn.violet':
        this.changeState(InnVioletState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.zone.village.inn.room.confirm':
        this.changeState(InnRoomConfirmState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.zone.village.leaderboards':
        this.changeState(VillageLeaderboardState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.zone.village.news.read':
        this.changeState(VillageNewsState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.zone.village.players.online':
        this.changeState(VillagePlayersOnlineState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.zone.village.trainer.challenge':
        this.changeState(TrainerChallengeState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.zone.village.trainer.fail':
        this.changeState(TrainerFailState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.zone.village.trainer.loiter':
        this.changeState(TrainerLoiterState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.zone.village.trainer.talk':
        this.changeState(TrainerTalkState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.zone.village.weapons.buy':
        this.changeState(WeaponsBuyState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.zone.village.weapons.loiter':
        this.changeState(WeaponsLoiterState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.zone.village.weapons.purchase':
        this.changeState(WeaponsPurchaseState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.zone.village.weapons.sell.confirm':
        this.changeState(WeaponsSellConfirmState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;

      case 'game.zone.village.weapons.sell.offer':
        this.changeState(WeaponsSellOfferState);
        this.zone && this.zone.handle_in(payload);
        return payload.message;


      default:
        this.zone && this.zone.handle_in(payload);
        return payload.message;
        break;
    }
  }

}
