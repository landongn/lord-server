import State from 'web/static/js/zones/base';



export default {
  cls: class CharacterListState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
      this.nameElement = null;
      this.characterName = null;
      this.characterSchema = null;
      this.characters = null;
    }
    load() {
      Mousetrap.bind('b', () => {
        this.game.handle_out('game.zone.character.select', 'character');
      });
    }

    play(i) {
      console.log(i, this.characters[i]);
      const char_id = this.characters[i].id || false;
      if (!char_id) { console.error("internal problem with ID mismatch"); return; }
      this.game.handle_out('game.zone.character.play', 'character', {id: char_id});
      Mousetrap.reset();
      Mousetrap.bind('b', () => {
        this.game.handle_out('game.zone.character.select', 'character');
      });
    }

    handle_in(payload) {
      console.log("payload for character list: ", payload);
      this.characters = payload.characters;
      for (var i = 0; i < payload.characters.length; i++) {
        Mousetrap.bind(i+1+'', (e) => {
          this.play(i-1);
        });
      }
    }
  },
  id: 'character.list'
}