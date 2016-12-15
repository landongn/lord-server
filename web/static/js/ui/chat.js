export default class Chatbox {
    constructor(gui, game) {
        this.element = document.querySelector('.chat');
        this.log = document.querySelector('.chat-wrap');
        this.presenceEl = document.querySelector('.presence');
        this.inputEl = document.querySelector('.chat-enter');
        this.gui = gui;
        this.game = game;
        this.inputEl.addEventListener('keypress', (e) => {
            if (e.keyCode !== 13) {
                return;
            }
            const message = this.inputEl.value;
            if (!this.game.character.name) { return; }
            const char = this.game.character.name;
            this.game.handle_out('game.zone.broadcast', 'zone', {
                message,
                character: char
            });
            this.inputEl.value = '';
            this.inputEl.focus();
        });

        this.visible = false;
        this.renderer = game.renderer || {};
    }



    toggleVisibility() {
        if (this.visible) {
            this.element.classList.remove('active');
            this.visible = false;
        } else {
            this.element.classList.add('active');
            this.visible = true;
        }
    }


    render(data = {}) {
        var temp = document.createElement('template');
        temp.innerHTML = `<li><span class="username">${data.from}</span>: ${data.message}</li>`;
        this.log.appendChild(temp.content);
    }
}