
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

    changeViewport(str) {
        this.element.classList = [];
        this.element.classList.add(str);
    }

    stripCommandQueue() {
        // const el = document.querySelector('[data-volitile]');
        // el ? el.remove() : console.log('nothing to clean');
    }
    render(data = {}) {
        const s = this.fragmentFromString(data.message);

        this.element.appendChild(s);
        this.stripCommandQueue();
        this.handleScroll();
        this.handleBufferCleanup();
    }

    clear() {
        this.element.innerHTML = '';
    }

    handleScroll() {
        if (document.body.scrollIntoView) {
            document.querySelector("li:last-child").scrollIntoView()
        } else {
            document.body.scrollTop = this.element.scrollHeight;
        }

    }

    handleBufferCleanup() {

    }
}