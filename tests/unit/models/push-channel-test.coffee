`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'push-channel', 'Unit | Model | push-channel', {
  # Specify the other units that are required for this test.
  needs: [
    'model:api'
    'model:remote-endpoint'
    'model:push-device'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
