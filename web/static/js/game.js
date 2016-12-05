import Renderer from 'web/static/js/engine/renderer';
import Connection from 'web/static/js/engine/connection';
import World from 'web/static/js/services/world';
import Gui from 'web/static/js/ui/gui';

export default class Game {
    constructor() {
        this.renderer = new Renderer(this);
        this.connection = new Connection(this);
        this.world = new World(this);
        this.gui = new Gui(this);
    }

    handle_in(message) {
        // console.log('message', message);
        const hasMessage = this.world.event(message);
        if (hasMessage) {
            this.renderer.render(message);
        }
    }
}