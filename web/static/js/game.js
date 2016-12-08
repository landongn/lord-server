import Renderer from 'web/static/js/engine/renderer';
import Connection from 'web/static/js/engine/connection';
import World from 'web/static/js/services/world';
import Gui from 'web/static/js/ui/gui';
import Input from 'web/static/js/engine/input';
import Character from 'web/static/js/mechanics/character';
import Session from 'web/static/js/mechanics/session';

export default class Game {
    constructor() {
        this.renderer = new Renderer(this);
        this.connection = new Connection(this);
        this.world = new World(this);
        this.gui = new Gui(this);
        this.input = new Input(this);
        this.character = null;
        this.session = new Session({});
        window.addEventListener('touchstart', (e) => {
            Mousetrap.trigger(e.target.attributes['data-command'].value);
        });
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
                if (!this.character) {this.character = new Character(payload)}
                this.character.update(payload);
                break;

            default:
                this.world.update(payload);
                break;
        }
    }

    handle_out(opcode, channel = '', payload = false) {
        const decoratedPayload = Object.assign({}, payload);
        decoratedPayload.token = this.session && this.session.token || '';
        decoratedPayload.user_id = this.session && this.session.id || '';
        this.connection.channels[channel].push(opcode, decoratedPayload);
    }
}