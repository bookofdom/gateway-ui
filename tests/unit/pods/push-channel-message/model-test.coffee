`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'push-channel-message', 'Unit | Model | push channel message', {
  # Specify the other units that are required for this test.
  needs: [
    'model:api'
    'model:remote-endpoint'
    'model:push-channel'
    'model:push-channel-message'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  assert.ok !!model
