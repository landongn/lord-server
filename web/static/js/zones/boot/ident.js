import State from 'web/static/js/zones/base';

export default {
    cls: class IdentState extends State {
      constructor(game, id) {
        super();
        this.game = game;
        this.id = id;
        this.emailAddress = null;
        this.password = null;
      }

      handle_in(payload) {
        switch(payload.opcode) {
          case 'game.client.ident-email':
            setTimeout(() => {
              this.focusEmailField();
            }, 0);
            break;

          case 'game.client.ident.success':
            setTimeout(() => {
              this.focusPasswordField();
            }, 0);
            break;

          case 'game.client.ident.notfound':
            setTimeout(() => {
              this.focusPasswordField();
            }, 0);
            break;

          case 'game.client.ident.password-fail':
            setTimeout(() => {
              this.focusPasswordField();
            }, 0);

          default:
            break;
        }
      }

      focusEmailField() {
        this.element = document.querySelector('input.action-input-email-address');
        this.element.focus();
        this.element.addEventListener('keypress', (e) => {
          if (e.keyCode === 13) {
            this.checkEmail();
          }
        });
      }

      focusPasswordField() {
        this.passwordEl = document.querySelector('input.action-input-password');
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
      }
      
      load() {
        Mousetrap.bind('enter', (e) => {
          if (this.emailAddress) {
            this.checkPassword();
          }

          if (this.password) {
            this.handle_out('password-identify', 'world', {
              email: this.emailAddress,
              password: this.password
            });
          }
        });

        Mousetrap.bind('e', (e) => {
          this.game.handle_out('email-ident', 'world');
        });
      }

    },

    id: 'boot.ident'
}