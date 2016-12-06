export default class Input {
    constructor(game) {
        this.game = game;
        this.responder = null;
        

    }

    requestInput(cls) {
        this.responder ? this.responder.resignResponder() : this.responder = cls;
        this.responder.focus();
    }
}