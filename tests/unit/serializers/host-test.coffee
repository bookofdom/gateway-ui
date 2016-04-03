`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'host', 'Unit | Serializer | host', {
  # Specify the other units that are required for this test.
  needs: [
    'serializer:host'
    'model:api'
  ]
}

# Replace this with your real tests.
test 'it serializes records', (assert) ->
  record = @subject()

  serializedRecord = record.serialize()

  assert.ok serializedRecord
