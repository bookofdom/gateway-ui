`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'timer', 'Unit | Model | timer', {
  # Specify the other units that are required for this test.
  needs: [
    'model:api'
    'model:job'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
