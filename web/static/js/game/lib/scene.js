
const FORWARD = 119;
const BACKWARD = 115;
const RIGHT_ROTATION = 100;
const LEFT_ROTATION = 97;
const UP = 32;

const XPOSB = 2850;

const Player_Start3 = [2806, -1285, -62];
const Camera_Start3 = [2806, -1266, 282]
const Camera_Start_RotationX = 0;
import {Socket} from 'phoenix';

export default class Scene {
  constructor(world) {
    this.socket = new Socket('/socket', {params: {token: window.zlordtoken}});
    this.socket.connect();
    this.eventbus = this.socket.channel('world:system', {});

    this.eventbus.join();
    this.eventbus.on('position', (data) => {
      const p = this.entities[data.id];
      if (p) {
        p.position.set(data.vec3.x, data.vec3.y, data.vec3.z);
      } else {
        this.createPlayer(data.id, data.vec3);
      }
    });
    this.world = world;
    this.entities = {};
    this.mobs = [];
    this.lights = {};
    this.scene = new THREE.Scene();
    this.moveIntent = false;
    this.terrain = null;
    this.mousePosition = null;

    this.cameraNewPos = new THREE.Vector3(0, 0, 0);

    // asset loader manager ##########
    this.manager = new THREE.LoadingManager();

    this.manager.onProgress = function ( item, loaded, total ) {
      console.log( item, loaded, total );
    }

    this.loader = new THREE.OBJLoader( this.manager );
  }

  createPlayer(id, pos) {
    const player = new THREE.Group();

    const playerMeshGeom = new THREE.BoxGeometry(5, 5, 5);
    playerMeshGeom.computeFaceNormals();
    const playerMat = new THREE.MeshToonMaterial({
      color: 0x00ffff,

    });
    const playerMesh = new THREE.Mesh(playerMeshGeom, playerMat);
    playerMesh.receiveShadows = true;
    playerMesh.castShadows = true;
    player.add(playerMesh);
    this.scene.add(player);
    player.position.set(pos.x, pos.y, pos.z);


    const player_pointLight = new THREE.PointLight(0xffffff, 1, 10, 100);
    player_pointLight.position.set(Player_Start3[0], Player_Start3[1], Player_Start3[2]);
    var spotLight = new THREE.SpotLight( 0xffffff, 1 );
    this.spotLight = spotLight;
    spotLight.position.set( Player_Start3[0], Player_Start3[1], 120 );
    spotLight.rotation.set( 0, 1, 0);

    spotLight.castShadow = true;

    spotLight.shadow.mapSize.width = 1024;
    spotLight.shadow.mapSize.height = 1024;

    spotLight.shadow.camera.near = 500;
    spotLight.shadow.camera.far = 4000;
    spotLight.shadow.camera.fov = 10;

    player.add(player_pointLight);
    player.add(spotLight);

    this.entities[id] = player;
  }

  load(renderer, camera) {
    this.camera = camera;
    this.lights["ambient"] = new THREE.AmbientLight( 0x333333, 1 );
    this.lights['skybox'] = new THREE.HemisphereLight(0x111111, 0x000000, 0.5);
    this.lights['skyboxb'] = new THREE.HemisphereLight(0xffffff, 0x333333, 0.3);
    this.lights["skybox"].position.set( Player_Start3[0], -1212, 346 );

    this.scene = new THREE.Scene();
    this.scene.fog = new THREE.FogExp2( 0x000011, 0.001 );

    renderer.setClearColor( this.scene.fog.color );


    this.loader.load( '/geom/oasis.obj', ( object ) => {
      console.log(object);
      object.traverse( function ( child ) {
        if ( child instanceof THREE.Mesh ) {
          switch(child.name) {
            case "oasis":
              child.material = new THREE.MeshToonMaterial({ color:0xdbd37a });
              child.castShadow = true;
              child.receiveShadows = true;
              break;

            case "sea":
              child.material = new THREE.MeshToonMaterial({ color:0x00ffff });
              break;

            case "water":
              child.material = new THREE.MeshToonMaterial({ color:0x7aa6db });
              break;
          }


        }
      });
      this.terrain = object;
      window.terrain = object;
      object.rotation.x = 0;
      this.scene.add( object );

    });
    this.addLights();
    this.addEntities();
    this.ready(camera);
  }

  addLights() {
    const keys = Object.keys(this.lights);
    for (var i = 0; i < keys.length; i++) {
      this.scene.add(this.lights[keys[i]]);
    }
  }

  addEntities() {
    this.player = new THREE.Group();

    const playerMeshGeom = new THREE.BoxGeometry(5, 5, 5);
    playerMeshGeom.computeFaceNormals();
    const playerMat = new THREE.MeshToonMaterial({
      color: 0x00ffff,

    });
    const playerMesh = new THREE.Mesh(playerMeshGeom, playerMat);
    playerMesh.receiveShadows = true;
    playerMesh.castShadows = true;
    this.player.add(playerMesh);
    this.scene.add(this.player);
    this.player.position.set(Player_Start3[0], Player_Start3[1], Player_Start3[2]);


    const player_pointLight = new THREE.PointLight(0xffffff, 1, 10, 100);
    player_pointLight.position.set(Player_Start3[0], Player_Start3[1], Player_Start3[2]);
    var spotLight = new THREE.SpotLight( 0xffffff, 1 );
    this.spotLight = spotLight;
    spotLight.position.set( Player_Start3[0], Player_Start3[1], 120 );
    spotLight.rotation.set( 0, 1, 0);
    this.world.gui.add(spotLight, "visible");
    spotLight.castShadow = true;

    spotLight.shadow.mapSize.width = 1024;
    spotLight.shadow.mapSize.height = 1024;

    spotLight.shadow.camera.near = 500;
    spotLight.shadow.camera.far = 4000;
    spotLight.shadow.camera.fov = 10;

    // player_pointLight.position.set(Player_Start3[0], -1090, 21);
    this.player.add(player_pointLight);
    this.player.add(spotLight);

    this.camera.lookAt(this.player.position);

    this.world.gui.add(this.player.position, 'x');
    this.world.gui.add(this.player.position, 'y');
    this.world.gui.add(this.player.position, 'z');

    this.world.gui.add(this, 'lookAtPlayer');

    this.dayCycleMax = 1;
    this.dayCycle = 0.5;
    this.dayCycleIncrement = 0.0001;
    this.daytime = false;
  }

  lookAtPlayer() {
    this.camera.lookAt(this.player);
  }
  ready(camera) {
    camera.position.set(Camera_Start3[0], Camera_Start3[1], Camera_Start3[2]);
    camera.lookAt(this.player);
    camera.rotateX(Camera_Start_RotationX);

  }
  update(delta) {

    this.camera.updateMatrixWorld();
    if (this.dayCycle >= 1) {
      this.daytime = false;
    }

    if (this.daytime) {
      this.dayCycle += this.dayCycleIncrement;
    }
    if (this.daytime == false) {
      this.dayCycle -= this.dayCycleIncrement;
    }
    if (this.dayCycle <= 0) {
      this.daytime = true;
    }
    this.spotLight.intensity = this.dayCycle;

    if (this.LMBDown) {
      this.player.lookAt(this.mousePosition);
      this.player.position.lerp(this.mousePosition, (2.0 * delta));
      const camvec3 = this.player.position.clone();
      camvec3.set(this.mousePosition.x, this.mousePosition.y, this.camera.position.z);
      this.camera.position.lerp(camvec3, 1.0 * delta);
      this.eventbus.push("game.client.position.update", {id: window.zlordtoken, vec3: this.player.position});
    }
  }



  keyDown(e) {}
  keyUp(e) {}

  mousemove(e) {

  }
  leftClick(e, intersections) {
    this.LMBDown = true;
    this.mousePosition= intersections[0].point;
  }
  mouseup(e) {
    var self = this;
    this.LMBLock ? void(0) : (function() {
      self.LMBLock = true;
      setTimeout(() => { self.LMBDown = false; }, 4000);
    }());

  }
  button1Up(e) {}
  button2Up(e) {}

}