export default class Character {
    constructor(game, char) {
        this.id = char.id;
        this.name = char.name;
        this.level = char.level;
        this.experience = char.experience;
        this.gold = char.gold;
        this.gems = char.gems;
        this.is_alive = char.is_alive;
        this.health = char.health;
        this.defense = char.defense;
        this.strength = char.strength;
        this.endurance = char.endurance;
        this.luck = char.luck;
        this.game = game;
    }

    update(char) {
        this.id = char.id;
        this.name = char.name;
        this.level = char.level;
        this.experience = char.experience;
        this.gold = char.gold;
        this.gems = char.gems;
        this.is_alive = char.is_alive;
        this.health = char.health;
        this.defense = char.defense;
        this.strength = char.strength;
        this.endurance = char.endurance;
        this.luck = char.luck;
    }
}