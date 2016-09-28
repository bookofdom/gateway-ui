`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'proxy-endpoint-test', 'Unit | Model | proxy endpoint test', {
  # Specify the other units that are required for this test.
  needs: [
    'model:proxy-endpoint'
    'model:proxy-endpoint-test-argument'
    'model:proxy-endpoint-test-header'
    'model:proxy-endpoint-test-query-parameter'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store();
  assert.ok !!model
