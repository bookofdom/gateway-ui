`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'ap-list-nav-vertical-icon', 'Integration | Component | ap list nav vertical icon', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2
  @render hbs """
    {{#ap-list-nav-vertical-icon}}
    {{/ap-list-nav-vertical-icon}}
  """
  assert.equal @$().find('.ap-list-nav').size(), 1
  assert.equal @$().find('.ap-list-nav-vertical-icon').size(), 1
