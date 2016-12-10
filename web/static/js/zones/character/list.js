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
    }
    load() {
      Mousetrap.bind('b', () => {
        this.game.handle_out('game.zone.character.select', 'character');
      });
    }

    play(i) {
      this.game.handle_out('game.zone.character.play', 'character', {id: i});
      Mousetrap.reset();
      Mousetrap.bind('b', () => {
        this.game.handle_out('game.zone.character.select', 'character');
      });
    }

    handle_in(payload) {
      for (var i = payload.characters.length - 1; i >= 0; i--) {
        Mousetrap.bind(i+1+'', () => {
          this.play(i);
        });
      }
      console.log('payload for list', payload);
    }
  },
  id: 'character.list'
}