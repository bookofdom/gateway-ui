`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'remote-endpoint-environment-datum', 'Unit | Model | remote endpoint environment datum', {
  # Specify the other units that are required for this test.
  needs: [
    'model:environment'
    'model:remote-endpoint'
    'model:remote-endpoint-argument'
    'model:remote-endpoint-environment-variable'
    'model:remote-endpoint-header'
    'model:remote-endpoint-host'
    'model:remote-endpoint-push-platform'
    'model:remote-endpoint-query-parameter',
    'model:remote-endpoint-environment-datum-scratch-pad'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
