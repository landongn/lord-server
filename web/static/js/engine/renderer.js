
export default class Renderer {
    constructor(game) {
        this.element = document.getElementById('log');
        this.game = game;
    }

    fragmentFromString(strHTML) {
        var temp = document.createElement('template');
        temp.innerHTML = strHTML;
        return temp.content;
    }

    stripCommandQueue() {
        const el = document.querySelectorAll('li.command');
        el.length >= 2 ? el[0].remove() : void(0);
    }
    render(data = {}) {
        const s = this.fragmentFromString(data.message);

        this.element.appendChild(s);
        this.stripCommandQueue();
        this.handleScroll();
        this.handleBufferCleanup();
    }

    clear() {
        console.log('clearing');
        this.element.innerHTML = '';
    }

    handleScroll() {

        this.element.scrollTop = this.element.scrollHeight;
    }

    handleBufferCleanup() {

    }
}