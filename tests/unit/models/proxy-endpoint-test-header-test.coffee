`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'proxy-endpoint-test-header', 'Unit | Model | proxy endpoint test header', {
  # Specify the other units that are required for this test.
  needs: [
    'model:proxy-endpoint-test'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
