import State from 'web/static/js/zones/base';


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
      this.game.handle_out('game.zone.forest.loiter', 'forest');
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

      switch(payload.opcode) {
        case 'game.zone.village.loiter':
          for (var i = payload.actions.length - 1; i >= 0; i--) {
            Mousetrap.unbind(payload.actions[i]);
            Mousetrap.bind(payload.actions[i], (e) => {
              const fn = `${e.key}KeyPressed`;
              this[fn] && this[fn]();
            });
          }
      }
    }
  },
  id: 'village.loiter'
}