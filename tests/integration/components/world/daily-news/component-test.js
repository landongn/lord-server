import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';

moduleForComponent('world/daily-news', 'Integration | Component | world/daily news', {
  integration: true
});

test('it renders', function(assert) {

  // Set any properties with this.set('myProperty', 'value');
  // Handle any actions with this.on('myAction', function(val) { ... });

  this.render(hbs`{{world/daily-news}}`);

  assert.equal(this.$().text().trim(), '');

  // Template block usage:
  this.render(hbs`
    {{#world/daily-news}}
      template block text
    {{/world/daily-news}}
  `);

  assert.equal(this.$().text().trim(), 'template block text');
});
