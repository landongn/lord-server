import ConnectState from '../zones/world/connect';
import WelcomeNewsState from '../zones/world/welcome_news';
import WorldLeaderboardState from '../zones/world/leaderboards';
import WorldInstructionsState from '../zones/world/instructions';

import CharacterSelectState from '../zones/character/select';
import CharacterCreateState from '../zones/character/create';
import CharacterListState from '../zones/character/list';
import CharacterDeleteState from '../zones/character/delete';

import ArmorLoiterState from '../zones/village/armor/armorLoiter';
import ArmorBuyState from '../zones/village/armor/armorBuy';
import ArmorPurchaseState from '../zones/village/armor/armorPurchase';
import ArmorSellConfirmState from '../zones/village/armor/armorSellConfirm';
import ArmorSellOfferState from '../zones/village/armor/armorSellOffer';

import InnBardState from '../zones/village/inn/innBard';
import InnStatsState from '../zones/village/inn/innStats';
import InnMessageboardState from '../zones/village/inn/innMessageboard';
import InnNewsState from '../zones/village/inn/innNews';
import InnBartenderState from '../zones/village/inn/innBartender';
import InnLoiterState from '../zones/village/inn/innLoiter';
import InnRoomAskState from '../zones/village/inn/innRoomAsk';
import InnVioletState from '../zones/village/inn/innViolet';
import InnRoomConfirmState from '../zones/village/inn/inRoomConfirm';

import VillageLeaderboardState from '../zones/village/leaderboards';
import VillageNewsState from '../zones/village/news';
import VillagePlayersOnlineState from '../zones/village/players-online';
import VillageLoiterState from '../zones/village/loiter';
import VillageStatsState from '../zones/village/stats';

import TrainerChallengeState from '../zones/village/trainer/trainerChallenge';
import TrainerFailState from '../zones/village/trainer/trainerFail';
import TrainerWinState from '../zones/village/trainer/trainerWin';
import TrainerLoiterState from '../zones/village/trainer/trainerLoiter';
import TrainerQuestionState from '../zones/village/trainer/trainerQuestion';
import TrainerFightState from '../zones/village/trainer/trainerFight';

import WeaponsBuyState from '../zones/village/weapons/weaponsBuy';
import WeaponsLoiterState from '../zones/village/weapons/weaponsLoiter';
import WeaponsPurchaseState from '../zones/village/weapons/weaponsPurchase';
import WeaponsSellConfirmState from '../zones/village/weapons/weaponsSellConfirm';
import WeaponsSellOfferState from '../zones/village/weapons/weaponsSellOffer';

import HealerLoiterState from '../zones/village/healer/healer-loiter';
import HealerHealAllState from '../zones/village/healer/healer-heal-all';
import HealerHealFullState from '../zones/village/healer/healer-heal-full';

import ForestLoiterState from '../zones/forest/loiter';
import ForestFightState from '../zones/forest/fight';
import ForestRunAwayState from '../zones/forest/runaway';

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
      [VillageStatsState.id]: new VillageStatsState.cls(game, VillageStatsState.id),

      [TrainerFightState.id]: new TrainerFightState.cls(game, TrainerFightState.id),
      [TrainerChallengeState.id]: new TrainerChallengeState.cls(game, TrainerChallengeState.id),
      [TrainerFailState.id]: new TrainerFailState.cls(game, TrainerFailState.id),
      [TrainerLoiterState.id]: new TrainerLoiterState.cls(game, TrainerLoiterState.id),
      [TrainerQuestionState.id]: new TrainerQuestionState.cls(game, TrainerQuestionState.id),
      [TrainerWinState.id]: new TrainerWinState.cls(game, TrainerWinState.id),
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
      [ForestRunAwayState.id]: new ForestRunAwayState.cls(game, ForestFightState.id),
    };

    this.zone = null;

  }

  update(payload) {
  }

  changeState(zone_id) {
    console.log('flipping to state ', zone_id);
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
      this.zone.bindKeys(payload);
      this.zone.handle_in ? this.zone.handle_in(payload) : void(0);
      return payload.message;
    } else {
      this.zone.bindKeys(payload);
      this.zone.handle_in ? this.zone.handle_in(payload) : void(0);
      return payload.message;
    }

  }
}
