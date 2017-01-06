`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'proxy-endpoint', 'Unit | Model | proxy endpoint', {
  # Specify the other units that are required for this test.
  needs: [
    'model:api'
    'model:endpoint-group'
    'model:environment'
    'model:proxy-endpoint-component'
    'model:proxy-endpoint-route'
    'model:proxy-endpoint-schema'
    'model:proxy-endpoint-test'
    'model:proxy-endpoint-channel'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
