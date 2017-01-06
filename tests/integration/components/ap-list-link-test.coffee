`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'ap-list-link', 'Integration | Component | ap list link', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  @render hbs """
    {{ap-list-link
      t='foobar'
      icon='test-icon'}}
  """

  assert.equal @$().find('.gateway-test-icon').length, 1
  assert.equal @$().find('[data-t="foobar"]').length, 1
