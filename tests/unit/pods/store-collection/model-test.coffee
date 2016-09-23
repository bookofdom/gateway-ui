`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'store-collection', 'Unit | Model | store collection', {
  # Specify the other units that are required for this test.
  needs: [
    'model:store-object'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
