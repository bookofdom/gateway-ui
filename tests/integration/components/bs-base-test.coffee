`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'bs-base', 'Integration | Component | bs base', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 1
  @render hbs """{{bs-base classNames='base'}}"""
  assert.equal @$().find('.base').length, 1
