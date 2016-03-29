`import { moduleForModel, test } from 'ember-qunit'`
`import Pretender from 'pretender'`

moduleForModel 'api', 'Unit | Serializer | application', {
  # Specify the other units that are required for this test.
  needs: ['serializer:api']
}

# Replace this with your real tests.
test 'it serializes records', (assert) ->
  # let record = this.subject();
  #
  # let serializedRecord = record.serialize();
  #
  # assert.ok(serializedRecord);
