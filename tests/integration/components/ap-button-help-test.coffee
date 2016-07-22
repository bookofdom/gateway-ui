`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'ap-button-help', 'Integration | Component | ap button help', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 1

  @render hbs """
    {{ap-button-help url='http://www.example.net'}}
  """

  assert.equal @$().find('a').attr('href'), 'http://www.example.net'
