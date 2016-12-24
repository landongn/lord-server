import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';

moduleForComponent('character/info-sheet', 'Integration | Component | character/info sheet', {
  integration: true
});

test('it renders', function(assert) {

  // Set any properties with this.set('myProperty', 'value');
  // Handle any actions with this.on('myAction', function(val) { ... });

  this.render(hbs`{{character/info-sheet}}`);

  assert.equal(this.$().text().trim(), '');

  // Template block usage:
  this.render(hbs`
    {{#character/info-sheet}}
      template block text
    {{/character/info-sheet}}
  `);

  assert.equal(this.$().text().trim(), 'template block text');
});
