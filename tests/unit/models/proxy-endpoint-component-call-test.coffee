`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'proxy-endpoint-component-call', 'Unit | Model | proxy endpoint component call', {
  # Specify the other units that are required for this test.
  needs: [
    'model:proxy-endpoint-component',
    'model:proxy-endpoint-component-transformation',
    'model:remote-endpoint'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
