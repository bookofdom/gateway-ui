`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'proxy-endpoint-channel', 'Unit | Model | proxy endpoint channel', {
  # Specify the other units that are required for this test.
  needs: [
    'model:proxy-endpoint'
    'model:remote-endpoint'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
