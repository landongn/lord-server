import State from 'web/static/js/zones/base';


export default {
  cls: class ForestFightState extends State {
    constructor(game, id) {
      super();
      this.game = game;
      this.id = id;
      this.alreadyAttacking = false;
    }

    load() {

    }

    out(place) {
      console.log('out to', place);
      this.game.handle_out(`game.zone.forest.${place}`, 'forest');
    }

    aKeyPressed() {
      if (this.alreadyAttacking) { return; }
      this.game.handle_out('game.zone.forest.attack', 'forest', {id: this.game.character.id})
    }

    pKeyPressed() {
      this.out('power-move');
    }

    rKeyPressed() {
      this.out('loiter');
    }

    handle_in(payload) {


      switch(payload.opcode) {
        case 'game.zone.forest.fight':
          const actions = payload.actions;
          for (var i = 0; i < actions.length; i++) {
            const action = payload.actions[i];
            console.log('bound handler for ', `${action}KeyPressed`, action);
            Mousetrap.bind(action, (e) => {
              const fn = `${action}KeyPressed`;
              this[fn]();
            });
          }
          console.log('fight start: ', payload);
          break;

        case 'game.zone.forest.round':
          this.alreadyAttacking = true;
          console.log('game round: ', payload);
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

        case 'game.zone.forest.kill':
          this.game.audio.play('swing');
          this.game.audio.play('flshhit2');
          this.game.audio.play(payload.fight.mob.s_die);
          Mousetrap.unbind('a');
          Mousetrap.unbind('r');
          Mousetrap.bind('space', () => {
            this.out('loiter');
          });
          break;

        case 'game.zone.forest.killed':
          Mousetrap.unbind('a');
          Mousetrap.unbind('r');
          this.game.audio.play(payload.fight.mob.s_atk);
          this.game.audio.play('flshhit2');
          this.game.audio.play('death_m');

          Mousetrap.bind('space', () => {
            window.location.reload();
          });

        default:
          console.log('unbound forest state', payload.opcode);
          break;
      }
    }
  },
  id: 'forest.fight'
}