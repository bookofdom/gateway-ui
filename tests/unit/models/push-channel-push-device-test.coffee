`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'push-channel-push-device', 'Unit | Model | push device', {
  # Specify the other units that are required for this test.
  needs: [
    'model:api'
    'model:remote-endpoint'
    'model:push-channel'
    'model:push-message'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
