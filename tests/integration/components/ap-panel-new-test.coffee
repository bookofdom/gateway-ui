`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'ap-panel-new', 'Integration | Component | ap panel new', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 4
  @render hbs """{{ap-panel-new}}"""
  assert.equal @$().find('.ap-panel-new').length, 1
  assert.equal @$().find('.panel-heading').length, 1
  assert.equal @$().find('.in').length, 1
  @render hbs """{{ap-panel-new closed=true}}"""
  assert.equal @$().find('.in').length, 0

test 'it toggles', (assert) ->
  assert.expect 2
  @render hbs """{{ap-panel-new}}"""
  assert.equal @$().find('.in').length, 1
  @$().find('[data-toggle="collapse"]').click()
  assert.equal @$().find('.in').length, 0
