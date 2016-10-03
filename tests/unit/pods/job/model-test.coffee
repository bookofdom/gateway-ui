`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'job', 'Unit | Model | job', {
  # Specify the other units that are required for this test.
  needs: [
    'model:api'
    'model:endpoint-group'
    'model:environment'
    'model:job-component'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
