`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'store-object', 'Unit | Model | store object', {
  # Specify the other units that are required for this test.
  needs: [
    'model:store-collection'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
