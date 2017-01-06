`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'remote-endpoint', 'Unit | Model | remote endpoint', {
  # Specify the other units that are required for this test.
  needs: [
    'model:api'
    'model:remote-endpoint-argument'
    'model:remote-endpoint-environment-variable'
    'model:remote-endpoint-environment-datum'
    'model:remote-endpoint-header'
    'model:remote-endpoint-host'
    'model:remote-endpoint-push-platform'
    'model:remote-endpoint-query-parameter'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
