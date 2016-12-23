import Ember from 'ember';

export default Ember.Service.extend({
  init() {
    this.game = game;
    this.ctx = null;
    this.isMuted = false;
    this.muteEl = document.querySelector('.mute-button');
    try {
      const ctor = window.AudioContext || window.webkitAudioContext;
      this.ctx = new ctor();
    } catch (err) {
      console.error('No Audio API Support');
    }
  },
  cacheFor(k) {
    return this._cache[k] || false;
  },

  fadeOut() {

  },

  play(k, loop = false, ismp3 = false) {
    if (this.cacheFor(k)) {
      this.connect(k, loop);
    } else {
      this.load(k, loop, ismp3);
    }
  },

  make(k, buf, shouldLoop = false) {
    const sound = {
      buf: buf,
      output: this.ctx.destination,
      gainNode: this.ctx.createGain(),
      source: this.ctx.createBufferSource(),
      id: k,
      loop: shouldLoop,
      gain: -0.5,
    };

    sound.source.buffer = sound.buf;
    this._cache[k] = sound;
    return sound;
  },

  connect(key, shouldLoop = false) {
    const sound = this.make(key, this._cache[key].buf, shouldLoop);

    sound.source.connect(sound.gainNode);
    sound.source.connect(this.ctx.destination);
    sound.gainNode.connect(this.ctx.destination);
    if (this.game.gui.isMuted) {
      sound.gainNode.gain.value = -1;
    } else {
      sound.gainNode.gain.value = sound.gain;
    }
    sound.source.loop = shouldLoop;
    sound.source.start(0);
  },

  start() {
    this.source.start(0);
  },

  load(k, shouldLoop = false, ismp3 = false) {
    const request = new XMLHttpRequest();
    if (ismp3 === true) { request.open('GET', `/effects/${k}.mp3`, true); }
                  else  { request.open('GET', `/effects/${k}.wav`, true); }
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
});
