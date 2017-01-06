`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'ap-list-nav-circle-icon', 'Integration | Component | ap list nav circle icon', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2
  @render hbs """
    {{#ap-list-nav-circle-icon}}
    {{/ap-list-nav-circle-icon}}
  """
  assert.equal @$().find('.ap-list-nav').length, 1
  assert.equal @$().find('.ap-list-nav-circle-icon').length, 1
