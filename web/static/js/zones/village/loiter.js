import State from '../base';



export default {
  cls: class VillageLoiterState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
    }
    load() {

    }

    out(place) {
      console.log('out to', place);
      this.game.handle_out(`game.zone.village.${place}`, 'village');
    }

    fKeyPressed() {
      console.log('f touch');
      this.game.handle_out('game.zone.forest.loiter', 'forest');
    }

    kKeyPressed() {
      this.out('weapons.loiter');
    }

    iKeyPressed() {
      this.out('inn.loiter');
    }

    hKeyPressed() {
      this.out('healer.loiter');
    }

    yKeyPressed() {
      this.out('bank.loiter');
    }

    wKeyPressed() {
      this.out('mail');
    }

    cKeyPressed() {
      this.out('relations');
    }

    pKeyPressed() {
      this.out('players.online');
    }

    sKeyPressed() {
      this.game.handle_out('game.zone.fields.loiter', 'fields');
    }

    aKeyPressed() {
      this.out('armor.loiter')
    }

    vKeyPressed() {
      this.game.handle_out('game.zone.character.stats', 'character');
    }

    tKeyPressed() {
      this.out('trainer.loiter');
    }

    lKeyPressed() {
      this.out('players.list')
    }

    dKeyPressed() {
      this.out('news.read')
    }

    oKeyPressed() {
      this.out('other.loiter');
    }

    qKeyPressed() {
      this.game.handle_out('game.zone.character.quit-fields', 'characters');
    }


    handle_in(payload) {

      const self = this;
      const actions = payload.actions;
      for (var i = 0; i < actions.length; i++) {
        const action = payload.actions[i];
        Mousetrap.bind(action, (e) => {
          const fn = `${action}KeyPressed`;
          self[fn]();
        });
      }
    }
  },
  id: 'village.loiter'
}
