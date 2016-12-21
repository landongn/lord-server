import State from '../base';



export default {
  cls: class TrainerFightState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
      this.alreadyAttacking = false;
    }

    aKeyPressed() {
      if (this.alreadyAttacking) { return; }
      this.game.handle_out('game.zone.village.trainer.attack', 'village', {id: this.game.character.id})
    }

    handle_in(payload) {


      switch(payload.opcode) {
        case 'game.zone.village.trainer.fight':
          console.log('fight start: ', payload);
          break;

        case 'game.zone.village.trainer.round':
          this.alreadyAttacking = true;
            this.game.audio.play('swing');
            if (!payload.fight.char_missed) {
              setTimeout(() => {
                this.game.audio.play(payload.fight.mob.s_hit);
              }, 50);
            }


            setTimeout(() => {
              const el = document.querySelectorAll('.round-hidden');
              for (var i = 0; i < el.length; i++) {
                const itr = i;
                setTimeout(() => {
                  el[itr].classList.remove('round-hidden');
                  this.game.renderer.handleScroll();
                }, (itr * 60));
              }
              setTimeout(() => {
                this.alreadyAttacking = false;
              }, el.length * 60);

              this.game.audio.play(payload.fight.mob.s_atk);
              setTimeout(() => {
                if (!payload.fight.mob_missed) {
                  this.game.character.getHit();
                }
              }, 250);
            }, 1000);

          break;

        case 'game.zone.village.trainer.win':
          this.game.audio.play('swing');
          this.game.audio.play('flshhit2');
          this.game.audio.play(payload.fight.mob.s_die);
          Mousetrap.unbind('a');
          Mousetrap.unbind('r');
          Mousetrap.bind('space', () => {
            this.game.handle_out('game.zone.village.trainer.win', 'village');
          });
          break;

        case 'game.zone.village.trainer.lose':
          Mousetrap.unbind('a');
          Mousetrap.unbind('r');
          this.game.audio.play(payload.fight.mob.s_atk);
          this.game.audio.play('flshhit2');
          this.game.audio.play('death_m');

          Mousetrap.bind('space', () => {
            this.game.handle_out('game.zone.village.trainer.lose');
          });

        default:
          break;
      }
    }
  },
  id: 'game.zone.village.trainer.fight'
}
