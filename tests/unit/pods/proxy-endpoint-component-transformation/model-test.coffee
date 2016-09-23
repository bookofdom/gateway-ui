`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'proxy-endpoint-component-transformation', 'Unit | Model | proxy endpoint component transformation', {
  # Specify the other units that are required for this test.
  needs: [
    'model:proxy-endpoint-component'
    'model:proxy-endpoint-component-call'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
