import State from '../base';




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
          this.verifyNameUniqueness(this.nameElement.value);
        }
      });
    }

    verifyNameUniqueness(name) {
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

        case 'game.zone.character.name-reject':

          this.game.renderer.render({message: `<li>Sorry, <span class="special-light">${this.nameElement.value}</span> is taken.  Try something else.</li>`});
          this.nameElement.focus();
          break;
        default:
          break;
      }
    }
  },
  id: 'game.zone.character.create'
}
