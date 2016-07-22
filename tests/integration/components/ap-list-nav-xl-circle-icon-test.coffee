`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'ap-list-nav-xl-circle-icon', 'Integration | Component | ap list nav xl circle icon', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2
  @render hbs """
    {{#ap-list-nav-xl-circle-icon}}
    {{/ap-list-nav-xl-circle-icon}}
  """
  assert.equal @$().find('.ap-list-nav').size(), 1
  assert.equal @$().find('.ap-list-nav-xl-circle-icon').size(), 1
