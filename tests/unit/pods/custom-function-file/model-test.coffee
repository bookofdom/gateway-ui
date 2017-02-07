`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'custom-function-file', 'Unit | Model | custom function file', {
  # Specify the other units that are required for this test.
  needs: [
    'model:custom-function'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
