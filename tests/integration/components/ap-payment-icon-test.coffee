`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'ap-payment-icon', 'Integration | Component | ap payment icon', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 1
  @render hbs """{{ap-payment-icon}}"""
  assert.equal @$().text().trim(), ''
