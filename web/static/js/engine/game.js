import BaseRenderer from './renderer';

export default class Game {
    constructor() {
        this.gametime = 0;
        this.isConnected = 0;
        this.lastSync = 0;
        this.syncTime = 1000;
    }
}