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

    select(option) {
      this.game.handle_out('game.zone.character.select', 'character', {id: option.id});
    }

    handle_in(payload) {
      console.log('payload for list', payload);
    }
  },
  id: 'character.list'
}