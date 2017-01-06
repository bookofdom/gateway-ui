`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'ap-list-nav-', 'Integration | Component | ap list nav ', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 1
  @render hbs """
    {{#ap-list-nav}}
    {{/ap-list-nav}}
  """
  assert.equal @$().find('.ap-list-nav').length, 1
