let SCREEN_WIDTH = window.innerWidth;
let SCREEN_HEIGHT = window.innerHeight;
let IS_PAUSED = false;

import TheOasis from './lib/scene';

export default class World {
  constructor() {
    this.zones = {
      theoasis: new TheOasis(this),
    };
    this.terrain = null;
    this.zone = new THREE.Scene();
    this.clock = new THREE.Clock();


    const aspect = window.innerWidth / window.innerHeight;

    this.renderer = new THREE.WebGLRenderer({antialias: true});
    this.renderer.setPixelRatio(window.devicePixelRatio);
    this.renderer.setSize(SCREEN_WIDTH, SCREEN_HEIGHT);
    this.camera = new THREE.PerspectiveCamera(50, aspect, 1, 2500);
    this.renderer.shadowMap.enabled = true;
    this.stats = new Stats();
    this.stats.showPanel(1);
    document.querySelector('.game').appendChild(this.renderer.domElement);
    document.body.appendChild( this.stats.dom );

    window.addEventListener( 'resize', this.onWindowResize.bind(this), false );
    this.renderer.domElement.addEventListener( 'keydown', this.onKeyDown.bind(this) );
    this.renderer.domElement.addEventListener( 'keyup', this.onKeyUp.bind(this) );
    this.renderer.domElement.addEventListener( 'mousedown', this.onMouseDown.bind(this), false);
    this.renderer.domElement.addEventListener( 'mouseup', this.onMouseUp.bind(this), false);
    this.renderer.domElement.addEventListener( 'mousemove', this.onMouseMove.bind(this), false);

    window.world = this;
    // mouse picking ##########
    this.raycaster = new THREE.Raycaster();
    this.mouse = new THREE.Vector2();

    this.gui = new dat.GUI({ height  : 4 * 32 - 1 });
    this.gui.add(this.camera.position, 'x');
    this.gui.add(this.camera.position, 'y');
    this.gui.add(this.camera.position, 'z');

    this.gui.add(this.camera.rotation, 'x', 0, 1);
    this.gui.add(this.camera.rotation, 'y', 0, 1);
    this.gui.add(this.camera.rotation, 'z', 0, 1);
    // start rendering ########
    requestAnimationFrame(this.tick.bind(this));
  }

  changeScene(name) {
    if (this.zones[name]) {
      this.zone = this.zones[name];
      this.zone.load(this.renderer, this.camera);
    }
  }

  onWindowResize() {
    SCREEN_WIDTH = window.innerWidth;
    SCREEN_HEIGHT = window.innerHeight;
    this.camera.aspect = SCREEN_WIDTH / SCREEN_HEIGHT;
    this.camera.updateProjectionMatrix();
    this.renderer.setSize( SCREEN_WIDTH, SCREEN_HEIGHT );
    this.tick();
  }

  // ## Input Handling ######################
  onKeyDown(e) {
    switch (e.keyCode) {
      case FORWARD:
        this.forwardPressed = true;
        break;

      case BACKWARD:
        this.backwardPressed = false;
        break;

      case LEFT_ROTATION:
        this.leftPressed = false;
        break;

      case RIGHT_ROTATION:
        this.rightPressed = false;
        break;
    }
  }

  onKeyUp(e) {
    switch (e.keyCode) {
      case FORWARD:
        this.forwardPressed = false;
        break;

      case BACKWARD:
        this.backwardPressed = false;
        break;

      case LEFT_ROTATION:
        this.leftPressed = false;
        break;

      case RIGHT_ROTATION:
        this.rightPressed = false;
        break;
    }
  }

  onMouseDown(e) {
    this.mouse.x = (e.clientX / this.renderer.domElement.clientWidth) * 2 - 1;
    this.mouse.y = -(e.clientY / this.renderer.domElement.clientHeight) * 2 + 1;
    this.raycaster.setFromCamera( this.mouse, this.camera );
    // See if the ray from the camera into the world hits one of our meshes
    var intersects = this.raycaster.intersectObject( this.zone.scene, true );
    if (intersects.length > 0) {
      this.zone.leftClick(e, intersects);
    }
  }
  onMouseUp(e) {
  }
  onMouseMove (e) {

    e.preventDefault();

  }
  getInput() {
    return [this.forwardPressed ? FORWARD : null,
      this.backwardPressed ? BACKWARD : null,
      this.rightPressed ? RIGHT_ROTATION : null,
      this.leftPressed ? LEFT_ROTATION : null];
  }

  // Dragons Below #########################
  tick() {
    var delta = this.clock.getDelta();
    this.stats.begin();
    this.zone.update(delta);
    this.render(delta);
    this.stats.end();
  }

  render(delta) {

    this.renderer.clear();
    this.renderer.setViewport(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    this.renderer.render(this.zone.scene, this.camera);
    requestAnimationFrame(this.tick.bind(this));
  }
  update(payload = {}) {}
}

