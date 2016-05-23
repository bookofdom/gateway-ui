`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'remote-endpoint-push-platform', 'Unit | Model | remote endpoint push platform', {
  # Specify the other units that are required for this test.
  needs: [
    'model:remote-endpoint'
    'model:remote-endpoint-environment-datum'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
