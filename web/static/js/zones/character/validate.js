import State from '../base';



export default {
  cls: class CharacterValidateState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
      this.cls = null;
      this.name = null;
    }

    load() {

      Mousetrap.bind('k', () => {
        this.chooseClass(1);
      });
      Mousetrap.bind('d', () => {
        this.chooseClass(2);
      });
      Mousetrap.bind('l', () => {
        this.chooseClass(3);
      });

      Mousetrap.bind('b', () => {
        this.game.handle_out('game.zone.character.select', 'character');
      });

    }

    chooseClass(cls) {
      this.cls = cls;
      this.game.handle_out('game.zone.character.class-selected', 'character', {class: this.cls, name: this.name});
    }

    handle_in(payload) {

      switch(payload.opcode) {

        case 'game.zone.character.confirm':
          this.name = payload.name;
          break;

        case 'game.zone.character.birth':
          Mousetrap.bind('h', () => {
            this.game.handle_out('game.zone.village.loiter', 'village');
          });

        default:
          break;
      }
    }
  },
  id: 'game.zone.character.validate.disabled'
}
