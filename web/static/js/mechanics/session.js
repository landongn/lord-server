
export default class Session {
    constructor(user) {
        this.id = user.id;
        this.name = user.name || '';
        this.email = user.email || '';
        this.token = user.token || '';
    }
}