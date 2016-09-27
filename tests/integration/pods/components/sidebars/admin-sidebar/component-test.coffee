`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'sidebars/admin-sidebar', 'Integration | Component | sidebars/admin sidebar', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{sidebars/admin-sidebar}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#sidebars/admin-sidebar}}
      template block text
    {{/sidebars/admin-sidebar}}
  """

  assert.equal @$().text().trim(), 'template block text'
