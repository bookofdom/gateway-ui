`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'custom-function', 'Unit | Model | custom function', {
  # Specify the other units that are required for this test.
  needs: [
    'model:api'
    'model:custom-function-file'
    'model:custom-function-test'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
