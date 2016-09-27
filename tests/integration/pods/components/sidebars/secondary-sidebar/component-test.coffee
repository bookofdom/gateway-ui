`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'sidebars/secondary-sidebar', 'Integration | Component | sidebars/secondary sidebar', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{sidebars/secondary-sidebar}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#sidebars/secondary-sidebar}}
      template block text
    {{/sidebars/secondary-sidebar}}
  """

  assert.equal @$().text().trim(), 'template block text'
