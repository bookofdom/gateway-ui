`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'ap-list-nav-vertical-circle-icon', 'Integration | Component | ap list nav vertical circle icon', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2
  @render hbs """
    {{#ap-list-nav-vertical-circle-icon}}
    {{/ap-list-nav-vertical-circle-icon}}
  """
  assert.equal @$().find('.ap-list-nav').length, 1
  assert.equal @$().find('.ap-list-nav-vertical-circle-icon').length, 1
