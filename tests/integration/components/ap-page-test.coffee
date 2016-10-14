`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'ap-page', 'Integration | Component | ap page', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 1
  @render hbs """{{ap-page}}"""
  assert.equal @$().find('.ap-page').length, 1
