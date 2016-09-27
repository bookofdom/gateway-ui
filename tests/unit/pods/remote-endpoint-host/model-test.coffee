`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'remote-endpoint-host', 'Unit | Model | remote endpoint host', {
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
