`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'ap-list-nav-vertical', 'Integration | Component | ap list nav vertical', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2
  @render hbs """
    {{#ap-list-nav-vertical}}
    {{/ap-list-nav-vertical}}
  """
  assert.equal @$().find('.ap-list-nav').length, 1
  assert.equal @$().find('.ap-list-nav-vertical').length, 1
