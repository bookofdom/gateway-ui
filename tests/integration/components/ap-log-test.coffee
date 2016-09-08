`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'ap-log', 'Integration | Component | ap log', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 1
  @render hbs """{{ap-log value='test log'}}"""
  assert.equal @$().find('.ap-log').size(), 1
