import State from 'web/static/js/zones/base';

export default {
  cls: class CharacterSelectState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.characterCount = 0;
      this.id = id;
    }
    load() {
      Mousetrap.bind('c', () => {
        this.createCharacter();
      });
      Mousetrap.bind('l', () => {
        this.reloadCharacters();
      });
    }
    handle_in(payload) {
      console.log('handling', payload);
      switch(payload.opcode) {
        case 'game.zone.character.list':
          this.characterCount = payload.characters.length;
          this.updateCharacterList(payload);
          break;

        case 'game.zone.character.create':
          break;

        case 'game.zone.character.delete':
          break;

        default:
          break;
      }
    }

    reloadCharacters() {
      this.game.handle_out('game.zone.character.list', 'character');
    }

    createCharacter() {
      this.game.handle_out('game.zone.character.create', 'character');
    }

    deleteCharacter(character) {
      this.game.handle_out('game.zone.character.delete', 'character', character);
    }

    updateCharacterList(payload) {
      for (var i = 0; i < this.characterCount; i++) {
        Mousetrap.unbind(i+'');
      }
      for (var i = 0; i < payload.characters.length; i++) {
        const char = payload.characters[i];
        Mousetrap.bind(i+'', () => {
          this.selectCharacter(i, char);
        });
      }
    }
  },
  id: 'character.select'
}