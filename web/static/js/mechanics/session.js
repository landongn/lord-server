import {Socket} from 'phoenix';

const WORLD = 'world:*'
export default class Session {
    constructor() {
        this.socketFactory = new Socket("/socket");

    }
}