export default class Chatbox {
    constructor(props) {
        this.element = document.getElementById('controller');
        this.visible = false;
        this.renderer = props.renderer || {};

        window.addEventListener('keypress', this.keyPressed.bind(this));
    }

    keyPressed(event) {
        if (event.keyCode === 13) {
            this.toggleVisibility();
        }
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
}