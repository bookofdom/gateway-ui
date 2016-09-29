`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'ap-iframe', 'Integration | Component | ap iframe', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 1
  @render hbs """{{ap-iframe src='/'}}"""
  assert.equal @$().find('iframe').length, 1
