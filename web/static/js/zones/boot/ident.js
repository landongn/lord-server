import State from 'web/static/js/zones/base';

export default {
    cls: class IdentState extends State {
      constructor(game, id) {
        super();
        this.game = game;
        this.id = id;
        this.emailAddress = null;
        this.password = null;
        this.element = null;
        this.passwordEl = null;
      }

      handle_in(payload) {
        switch(payload.opcode) {
          case 'game.client.ident-email':
            setTimeout(() => {
              this.focusEmailField();
            }, 0);
            break;

          case 'game.client.ident.success':
            Mousetrap.bind('r', (e) => {
              if (this.validLogin) {
                this.game.changeState('boot.ready');
              }
            });
            break;

          case 'game.client.ident.notfound':
            setTimeout(() => {
              this.focusPasswordField('password-register');
            }, 100);
            break;

          case 'game.client.ident.validuser':
            setTimeout(() => {
              this.focusPasswordField('password-returning');
            }, 100);
            break;

          case 'game.client.ident.password-fail':
            setTimeout(() => {
              this.focusPasswordField('password');
            }, 100);

          default:
            break;
        }
      }

      focusEmailField() {
        this.element = document.querySelector('.action-input-email-address');
        this.element.focus();
        this.element.addEventListener('keypress', (e) => {
          if (e.keyCode === 13) {
            this.checkEmail();
          }
        });
      }

      focusPasswordField(selector) {
        this.passwordEl = document.querySelector(`.action-input-${selector}`);
        this.passwordEl.focus();
        this.passwordEl.addEventListener('keypress', (e) => {
          if (e.keyCode === 13) {
            this.checkPassword();
          }
        });
      }

      checkEmail() {
        this.emailAddress = this.element.value;
        this.game.handle_out('email-identify', 'world', {email: this.emailAddress});
      }

      checkPassword() {
        this.password = this.passwordEl.value;
        if (this.emailAddress.length && this.password.length) {
          this.game.handle_out('password-identify', 'world', {
            email: this.emailAddress,
            password: this.password
          });
        }
      }

      load() {

        Mousetrap.bind('e', (e) => {
          this.game.handle_out('email-ident', 'world');
        });


      }

    },

    id: 'boot.ident'
}