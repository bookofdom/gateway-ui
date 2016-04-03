`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'endpoint-group', 'Unit | Serializer | endpoint-group', {
  # Specify the other units that are required for this test.
  needs: [
    'serializer:endpoint-group'
    'model:api'
  ]
}

# Replace this with your real tests.
test 'it serializes records', (assert) ->
  record = @subject()

  serializedRecord = record.serialize()

  assert.ok serializedRecord
