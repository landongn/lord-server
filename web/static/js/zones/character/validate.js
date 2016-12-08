import State from 'web/static/js/zones/base';

export default {
  cls: class CharacterValidateState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
      this.cls = null;
    }

    load() {

      Mousetrap.bind('1', () => {
        this.chooseClass(1);
      });
      Mousetrap.bind('2', () => {
        this.chooseClass(2);
      });
      Mousetrap.bind('3', () => {
        this.chooseClass(3);
      });

      Mousetrap.bind('b', () => {
        this.game.handle_out('game.zone.character.select', 'character');
      });

    }

    chooseClass(cls) {
      this.cls = cls;
      this.game.handle_out('game.zone.character.class-selected', 'character', {class: this.cls});
    }

    confirm() {
      this.game.handle_out('game.zone.character.birth', {class: this.cls});
    }

    handle_in(payload) {
      switch(payload.opcode) {

        case 'game.zone.character.class-selected':
          Mousetrap.unbind('c');
          Mousetrap.bind('c', () => {
            this.confirm();
          });
          break;

        default:
          break;
      }
    }
  },
  id: 'character.validate'
}