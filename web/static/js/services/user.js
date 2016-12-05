export default class User {
  constructor(game) {
    this.game = game;

    this.name = '';
    this.email = '';
    this.secret = '';

  }

  ident_challenge(payload) {
    this.name = payload.name;
    this.email = payload.email;
    this.secret = payload.secret;
  }
}