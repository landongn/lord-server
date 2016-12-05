export default class Gui {
  constructor(game) {
    this.game = game;

    const burst = new mojs.Burst({
      left: 0, top: 0,
      radius:   { 4: 32 },
      angle:    45,
      count:    14,
      children: {
        radius:       2.5,
        fill:         '#FD7932',
        scale:        { 1: 0, easing: 'quad.in' },
        pathScale:    [ .8, null ],
        degreeShift:  [ 13, null ],
        duration:     [ 500, 700 ],
        easing:       'quint.out'
      }
    });

    window.addEventListener( 'click', function (e) {
      console.log('clicked');
      const coords = { x: e.pageX, y: e.pageY };
      burst
        .tune(coords)
        .replay();
    });
  }

  status(payload) {

    console.log(payload);
  }
}