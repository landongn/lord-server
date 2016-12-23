import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';

moduleForComponent('nav/bottom-actions', 'Integration | Component | nav/bottom actions', {
  integration: true
});

test('it renders', function(assert) {

  // Set any properties with this.set('myProperty', 'value');
  // Handle any actions with this.on('myAction', function(val) { ... });

  this.render(hbs`{{nav/bottom-actions}}`);

  assert.equal(this.$().text().trim(), '');

  // Template block usage:
  this.render(hbs`
    {{#nav/bottom-actions}}
      template block text
    {{/nav/bottom-actions}}
  `);

  assert.equal(this.$().text().trim(), 'template block text');
});
