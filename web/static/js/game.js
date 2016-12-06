import Renderer from 'web/static/js/engine/renderer';
import Connection from 'web/static/js/engine/connection';
import World from 'web/static/js/services/world';
import Gui from 'web/static/js/ui/gui';
import Input from 'web/static/js/engine/input';

export default class Game {
    constructor() {
        this.renderer = new Renderer(this);
        this.connection = new Connection(this);
        this.world = new World(this);
        this.gui = new Gui(this);
        this.input = new Input(this);
    }

    handle_in(message) {
        const hasMessage = this.world.event(message);
        if (hasMessage) {
            this.renderer.render(message);
        }
    }

    handle_out(opcode, channel = '', payload = false) {
        if (payload) {
            this.connection.channels[channel].push(opcode, payload);
        } else {
            console.log('pushed opcode: ', opcode);
            this.connection.channels[channel].push(opcode);
        }
    }
}