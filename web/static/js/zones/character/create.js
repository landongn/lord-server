import State from '../base';

export default {
  cls: class CharacterCreate extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
      this.nameElement = null;
      this.characterName = null;
      this.confirmed = false;
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
      this.name = name;
      this.game.handle_out('game.zone.character.validate', 'character', {name: name});
      this.nameElement.blur();

    }

    kKeyPressed() {
      if (!this.confirmed) {return;}
      this.chooseClass(1);
    }
    dKeyPressed() {
      if (!this.confirmed) {return;}
      this.chooseClass(2);
    }
    lKeyPressed() {
      if (!this.confirmed) {return;}
      this.chooseClass(3);
    }

    hKeyPressed() {
      if (!this.confirmed) {return;}
      this.game.handle_out('game.zone.village.loiter', 'village');
    }
    chooseClass(cls) {
      this.cls = cls;
      this.game.handle_out('game.zone.character.class-selected', 'character', {class: this.cls, name: this.name});
    }

    handle_in(payload) {
      console.log('create handle_in', payload);
      switch(payload.opcode) {

        case 'game.zone.character.create':
          setTimeout(() => {
            this.configureNameField();
          }, 100);
          break;

        case 'game.zone.character.confirm':
          console.log('confirming ', this.name);
          this.confirmed = true;
          console.log('this.confirmed', this.confirmed);
          break;

        case 'game.zone.characater.validate':
          console.log('validate');
          break;

        case 'game.zone.character.birth':
          console.log('birth', payload);
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
