`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'ap-icon', 'Integration | Component | ap icon', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 1

  @render hbs """{{ap-icon icon='the-essentials-007'}}"""
  assert.equal @$().find('.gateway-the-essentials-007').size(), 1
