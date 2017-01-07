
class Game {
  constructor() {
    this.name = "Spaceballs: The Web Game";
    this.scene = null;
    this.scenes = {};
    this.activeSceneId = null;

    this.createInput('keydown', this.onKeyDown.bind(this));
    this.createInput('keyup', this.onKeyUp.bind(this));
    this.startRenderer();

  }

  addScene(name, def) {
    if (!this.scenes[name]) {
      this.scenes[name] = def;
    }
  }

  activate(name) {
    if (!this.scenes[name]) {
      throw new Error(`uanble to load scene, scene id: ${name} doesn't exist.`);
    }
    const scene = this.scenes[name];
    scene.prepareUnload();
    scene.destroy();

    this.scene = this.scenes[name];
    this.scene.hasLoaded ? this.scene.activate() : this.scene.load();
  }

  createInput(name, fn) {
    window.addEventListener(name, fn, false);
  }

}


