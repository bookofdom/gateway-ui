`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'environment-variable', 'Unit | Model | environment variable', {
  # Specify the other units that are required for this test.
  needs: [
    'model:environment'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
