`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'ap-list-nav-simple-icon', 'Integration | Component | ap list nav simple icon', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2
  @render hbs """
    {{#ap-list-nav-simple-icon}}
    {{/ap-list-nav-simple-icon}}
  """
  assert.equal @$().find('.ap-list-nav').length, 1
  assert.equal @$().find('.ap-list-nav-simple-icon').length, 1
