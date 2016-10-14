`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'job-component', 'Unit | Model | job component', {
  # Specify the other units that are required for this test.
  needs: [
    'model:job'
    'model:job-component-call'
    'model:job-component-transformation'
    'model:shared-component'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
