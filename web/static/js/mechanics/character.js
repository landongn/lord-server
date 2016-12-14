export default class Character {
    constructor(game) {
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
        this.mana = char.mana;
        this.luck = char.luck;
    }

    getHit() {
        const hits = ['flshhit1', 'flshhit2'];
        const sounds = ['gethit1m', 'gethit2m', 'gethit3m', 'gethit4m'];

        let soundForHit = hits[Math.floor(Math.random() * hits.length)];
        let soundForReaction = sounds[Math.floor(Math.random() * sounds.length)];

        this.game.audio.play(soundForHit);
        this.game.audio.play(soundForReaction);
        this.screenshake();
    }

    screenshake() {
        var element = document.getElementById('log');
        element.classList.add('shake');
        setTimeout(() => {
            element.classList.remove('shake');
        }, 200);
    }
}