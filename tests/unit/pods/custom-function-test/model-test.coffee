`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'custom-function-test', 'Unit | Model | custom function test', {
  # Specify the other units that are required for this test.
  needs: [
    'model:custom-function'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
