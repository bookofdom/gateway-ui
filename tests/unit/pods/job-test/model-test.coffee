`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'job-test', 'Unit | Model | job test', {
  # Specify the other units that are required for this test.
  needs: [
    'model:job'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
