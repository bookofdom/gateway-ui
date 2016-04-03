`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'environment', 'Unit | Serializer | environment', {
  # Specify the other units that are required for this test.
  needs: [
    'serializer:environment'
    'model:api'
    'model:environment-variable'
  ]
}

# Replace this with your real tests.
test 'it serializes records', (assert) ->
  record = @subject()

  serializedRecord = record.serialize()

  assert.ok serializedRecord
