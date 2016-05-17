`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'proxy-endpoint-test-query-parameter', 'Unit | Model | proxy endpoint test query parameter', {
  # Specify the other units that are required for this test.
  needs: [
    'model:proxy-endpoint-test'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
