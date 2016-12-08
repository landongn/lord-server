import State from 'web/static/js/zones/base';

export default {
  cls: class CharacterCreate extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
      this.nameElement = null;
      this.characterName = null;
    }
    load() {

      Mousetrap.bind('b', () => {
        this.game.handle_out('game.zone.character.select', 'character');
      });

      Mousetrap.bind('enter', () => {
        if (this.nameElement) {
          this.characterName = this.nameElement.value;
        }
      });
    }

    configureNameField() {
      this.nameElement = document.querySelector('.action-input-new-character');
      this.nameElement.focus();
      this.nameElement.addEventListener('keypress', (e) => {
        if (e.keyCode === 13) {
          this.verifyNameUniqueness();
        }
      });
    }

    verifyNameUniqueness() {
      const name = this.nameElement.value;
      this.game.handle_out('game.zone.character.validate', 'character', {name: name});
      this.nameElement.blur();

    }

    handle_in(payload) {
      switch(payload.opcode) {

        case 'game.zone.character.new':
          setTimeout(() => {
            this.configureNameField();
          }, 100);
          break;

        default:
          break;
      }
    }
  },
  id: 'character.create'
}