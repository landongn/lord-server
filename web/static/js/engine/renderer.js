
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

    render(data = {}) {
        const s = this.fragmentFromString(data.message);
        this.element.appendChild(s);
        this.handleScroll();
        this.handleBufferCleanup();
    }

    clear() {
        console.log('clearing');
        this.element.innerHTML = '';
    }

    handleScroll() {

    }

    handleBufferCleanup() {

    }
}