`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'registration', 'Unit | Model | registration', {
  # Specify the other units that are required for this test.
  needs: [
    'service:stripe'
    'model:plan'
    'model:stripe-card'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  assert.ok !!model
