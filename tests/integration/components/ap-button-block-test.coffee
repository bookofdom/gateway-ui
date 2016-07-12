`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'ap-button-block', 'Integration | Component | ap button block', {
  integration: true
}

test 'it triggers the specified action', (assert) ->
  done = assert.async()
  assert.expect 1

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{ap-button-block action='my-action'}}"""
  @on 'my-action', ->
    assert.ok true, 'action was called'
    done()
  @$().find('a').click()
