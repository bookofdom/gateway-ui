`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'ap-checkbox', 'Integration | Component | ap checkbox', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  @render hbs """{{ap-checkbox checked=true}}"""
  assert.ok @$().find('.ap-icon').is ':not(.invisible)'

  @render hbs """{{ap-checkbox checked=false}}"""
  assert.ok @$().find('.ap-icon').is '.invisible'
