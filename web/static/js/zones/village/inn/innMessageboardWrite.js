import State from '../../base';



export default {
  cls: class InnMessageBoardCreateState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
      this.pageIndex = 0;
    }

    handle_in() {
      setTimeout(() => {
        this.el = document.querySelector('.action-input-new-post');
        this.el.focus();
        this.el.addEventListener('keypress', (e) => {
          if (e.keyCode === 13) {
            this.save();
          }
        })
      }, 400);
    }



    save() {
      this.el = document.querySelector('.action-input-new-post');
      this.el.blur();
      this.post = this.el.value;
      this.game.handle_out('game.zone.village.inn.messageboard.save', 'village', {body: this.post})
    }

  },
  id: 'game.zone.village.inn.messageboard.write'
}
