`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'ap-radio', 'Integration | Component | ap radio', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 1
  @set 'value', true
  @render hbs """
    {{ap-radio value=value checked=true}}
    {{ap-radio value=value checked=false}}
  """
  assert.equal @$().find('.ap-radio').size(), 2
