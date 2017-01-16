`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'registration', 'Unit | Serializer | registration', {
  # Specify the other units that are required for this test.
  needs: [
    'service:stripeCheckout'
    'service:subscription'
    'model:plan'
    'serializer:registration'
  ]
}

test 'it serializes', (assert) ->
  model = @subject()
  serialized = model.serialize()
  assert.ok serialized
