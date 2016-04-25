`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'json-schema-node', 'Unit | Model | JsonSchemaNode',
  # Specify the other units that are required for this test.
  needs: ['serializer:json-schema-node']

test 'it serializes records', (assert) ->
  record = @subject()
  serializedRecord = record.serialize()
  assert.ok serializedRecord
