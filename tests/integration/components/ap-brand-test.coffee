`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'ap-brand', 'Integration | Component | ap brand', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{ap-brand}}"""

  assert.ok @$().find('.ap-brand-just-apis').size()

  # Template block usage:
  @render hbs """
    {{ap-brand brand='foobar' style='full'}}
  """

  assert.ok @$().find('.ap-brand-foobar').size()
