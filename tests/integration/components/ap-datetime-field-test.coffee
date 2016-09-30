`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'ap-datetime-field', 'Integration | Component | ap datetime field', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 1

  @render hbs """
    {{ap-datetime-field value='2016-01-01'}}
  """
  assert.equal @$().find('input').length, 1
