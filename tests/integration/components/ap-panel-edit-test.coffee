`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'ap-panel-edit', 'Integration | Component | ap panel edit', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 3
  @render hbs """{{ap-panel-edit}}"""
  assert.equal @$().find('.ap-panel-edit').size(), 1
  assert.equal @$().find('.panel-heading').size(), 0
  @render hbs """{{ap-panel-edit t='foo'}}"""
  assert.equal @$().find('.panel-heading').size(), 1
