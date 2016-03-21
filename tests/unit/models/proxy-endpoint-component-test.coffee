`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'proxy-endpoint-component', 'Unit | Model | proxy endpoint component', {
  # Specify the other units that are required for this test.
  needs: [
    'model:proxy-endpoint'
    'model:proxy-endpoint-component-call'
    'model:proxy-endpoint-component-transformation'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
