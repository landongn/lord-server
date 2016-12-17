import Renderer from 'web/static/js/engine/renderer';
import Connection from 'web/static/js/engine/connection';
import World from 'web/static/js/services/world';
import Gui from 'web/static/js/ui/gui';
import Input from 'web/static/js/engine/input';
import Character from 'web/static/js/mechanics/character';
import Session from 'web/static/js/mechanics/session';
import SoundManager from 'web/static/js/engine/audio';


export default class Game {
    constructor() {
        this.renderer = new Renderer(this);
        this.connection = new Connection(this);
        this.world = new World(this);
        this.gui = new Gui(this);
        this.input = new Input(this);
        this.character = new Character(this);
        this.session = new Session({});

        window.addEventListener('mouseup', (e) => {
            try {
                const val = parseInt(e.target.dataset.command, 10);
                if (isNaN(val)) {
                    Mousetrap.trigger(e.target.dataset.command);
                } else {
                    Mousetrap.trigger(val);
                }
            } catch (err) {
                console.log(err);
            }
        });
        window.addEventListener('touchend', (e) => {
            console.log('e', e.target.dataset);
            try {
              const val = parseInt(e.target.dataset.command, 10);
              if (isNaN(val)) {
                  Mousetrap.trigger(e.target.dataset.command);
              } else {
                  Mousetrap.trigger(val);
              }
          } catch (err) {
            console.info('unable to find touch target for ', e.target.dataset, err);
          }
        }, {useCapture: true, passive: true});
        this.audio = new SoundManager(this);
    }

    handle_in(message) {
        const hasMessage = this.world.event(message);
        if (hasMessage) {
            this.renderer.render(message);
        }
        const el = document.querySelector('.command-options')

    }

    update(system, payload) {
        switch(system) {
            case 'session':
                this.session.update(payload);
                break;

            case 'character':
                this.character.update(payload.payload);
                break;

            case 'chat':
                this.gui.handle_in(payload);
                break;

            default:
                this.world.update(payload);
                break;
        }
    }

    handle_out(opcode, channel = '', payload = false) {
        const decoratedPayload = Object.assign({}, payload);
        decoratedPayload.char_id = this.character.id || '';
        this.connection.channels[channel].push(opcode, decoratedPayload);
    }
}