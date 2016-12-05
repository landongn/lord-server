import {Socket} from 'phoenix';

export default class Renderer {
    constructor() {
        this.element = document.getElementById('log');
        this.socket = new Socket('/socket');
        this.socket.connect();
        this.channels = {};
        this.channels['world'] = this.socket.channel('world', {});
        this.channels['world'].join().receive('ok', resp => {
            this.render(resp, true);
        });
    }

    fragmentFromString(strHTML) {
        console.log(strHTML);
        var temp = document.createElement('template');
        temp.innerHTML = strHTML;
        return temp.content;
    }

    render(data = {}, fromServer = false) {
        if (fromServer) {
            const s = this.fragmentFromString(data.message);
            console.log(s);
            this.element.appendChild(s);
        } else {
            const entry = this.template(data);
        }

        this.handleScroll();
        this.handleBufferCleanup();
    }

    template(data = {}) {
        const el = document.createElement(data.tag);
        el.innerText = data.message;
        return el;
    }

    handleScroll() {

    }

    handleBufferCleanup() {

    }
}