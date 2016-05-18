`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'environment', 'Unit | Model | environment', {
  # Specify the other units that are required for this test.
  needs: [
    'model:api'
    'model:environment-variable'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
