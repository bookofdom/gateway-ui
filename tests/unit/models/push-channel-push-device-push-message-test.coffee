`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'push-channel-push-device-push-message', 'Unit | Model | push channel push device push message', {
  # Specify the other units that are required for this test.
  needs: [
    'model:api'
    'model:remote-endpoint'
    'model:push-channel'
    'model:push-channel-push-device'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
