import State from 'web/static/js/zones/base';


export default {
  cls: class CharacterListState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
      this.characters = null;
    }
    load() {
      Mousetrap.bind('b', () => {
        this.game.handle_out('game.zone.character.select', 'character');
      });
    }

    delete(i) {
      this.game.handle_out('game.zone.character.delete-confirm', 'character', {id: this.characters[i].id});
      Mousetrap.reset();
    }

    handle_in(payload) {
      console.log('payload from delete: ', payload);
      this.characters = payload.characters;
      for (var i = 0; i < payload.characters.length; i++) {
        Mousetrap.bind(i+1+'', (e) => {
          this.delete(i-1);
        });
      }
    }
  },
  id: 'character.delete'
}