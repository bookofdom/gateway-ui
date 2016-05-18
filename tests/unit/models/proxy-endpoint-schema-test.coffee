`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'proxy-endpoint-schema', 'Unit | Model | proxy endpoint schema', {
  # Specify the other units that are required for this test.
  needs: [
    'model:json-schema-node'
    'model:proxy-endpoint'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
