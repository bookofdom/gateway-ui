`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'ap-panel-upload', 'Integration | Component | ap panel upload', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 1
  @render hbs """{{ap-panel-upload}}"""
  assert.equal @$().find('.ap-panel-upload').size(), 1
