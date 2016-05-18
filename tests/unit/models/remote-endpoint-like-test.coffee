`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'remote-endpoint-like', 'Unit | Model | remote endpoint like', {
  # Specify the other units that are required for this test.
  needs: [
    'model:remote-endpoint-header'
    'model:remote-endpoint-host'
    'model:remote-endpoint-query-parameter'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
