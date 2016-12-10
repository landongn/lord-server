export default class SoundManager {
  constructor(game) {
    this.game = game;
    this.ctx = null;
    try {
      const ctor = window.AudioContext || window.webkitAudioContext;
      this.ctx = new ctor();
    } catch (err) {
      console.error('No Audio API Support');
    }

    this._cache = {};

    this.play('dragisat');
    this.play('darkwds1', true);
  }

  cacheFor(k) {
    return this._cache[k] || false;
  }

  fadeOut() {

  }
  play(k, loop = false) {
    if (this.cacheFor(k)) {
      this.connect(this._cache[k], k, loop);
    } else {
      this.load(k);
    }
  }

  make(k, buf, shouldLoop = false) {
    const sound = {
      buf: buf,
      output: this.ctx.destination,
      data: this.ctx.createBufferSource(),
      id: k,
      loop: shouldLoop,
      gain: 0.5,
    };

    sound.data.buffer = sound.buf;
    this._cache[k] = sound;
    return sound;
  }

  connect(sound, key, shouldLoop = false) {
    sound.data.connect(this.ctx.destination);
    sound.data.loop = shouldLoop;
    sound.data.start(0);
  }

  start() {
    this.source.start(0);
  }

  load(k, shouldLoop = false) {
    const request = new XMLHttpRequest();
    request.open('GET', `/effects/${k}.wav`, true);
    request.responseType = 'arraybuffer';
    request.onload = () => {
      this.ctx.decodeAudioData(request.response, (buffer) => {
        buffer.loop = shouldLoop;
        this.make(k, buffer, shouldLoop);
        this.play(k, shouldLoop);
      });
    }
    request.send();
  }
}