import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';

moduleForComponent('world/instruction-guide', 'Integration | Component | world/instruction guide', {
  integration: true
});

test('it renders', function(assert) {

  // Set any properties with this.set('myProperty', 'value');
  // Handle any actions with this.on('myAction', function(val) { ... });

  this.render(hbs`{{world/instruction-guide}}`);

  assert.equal(this.$().text().trim(), '');

  // Template block usage:
  this.render(hbs`
    {{#world/instruction-guide}}
      template block text
    {{/world/instruction-guide}}
  `);

  assert.equal(this.$().text().trim(), 'template block text');
});
