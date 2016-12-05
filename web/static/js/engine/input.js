export default class Input {
    constructor(game) {
        this.game = game;
        this.responder = null;
        Mousetrap.bind('enter', (e) => {
            this.responder && this.responder.keypress('enter', e);
        });

        Mousetrap.bind('e', (e) => {
            this.responder && this.responder.keypress('e', e);
        });

    }

    requestInput(cls) {
        this.responder ? this.responder.resignResponder() : this.responder = cls;
        this.responder.focus();
    }
}