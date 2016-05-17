`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'log', 'Unit | Model | log', {
  # Specify the other units that are required for this test.
  needs: [
    'model:api',
    'model:proxy-endpoint'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
