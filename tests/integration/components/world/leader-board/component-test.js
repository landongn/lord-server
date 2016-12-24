import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';

moduleForComponent('world/leader-board', 'Integration | Component | world/leader board', {
  integration: true
});

test('it renders', function(assert) {

  // Set any properties with this.set('myProperty', 'value');
  // Handle any actions with this.on('myAction', function(val) { ... });

  this.render(hbs`{{world/leader-board}}`);

  assert.equal(this.$().text().trim(), '');

  // Template block usage:
  this.render(hbs`
    {{#world/leader-board}}
      template block text
    {{/world/leader-board}}
  `);

  assert.equal(this.$().text().trim(), 'template block text');
});
