`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'proxy-endpoint-route', 'Unit | Model | proxy endpoint route', {
  # Specify the other units that are required for this test.
  needs: [
    'model:proxy-endpoint'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
