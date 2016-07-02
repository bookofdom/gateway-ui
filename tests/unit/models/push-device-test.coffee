`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'push-device', 'Unit | Model | push device', {
  # Specify the other units that are required for this test.
  needs: []
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
