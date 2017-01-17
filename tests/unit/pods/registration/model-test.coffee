`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'registration', 'Unit | Model | registration', {
  # Specify the other units that are required for this test.
  needs: [
    'service:stripeCheckout'
    'service:subscription'
    'model:plan'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  assert.ok !!model
