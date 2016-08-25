`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'account', 'Unit | Model | account',
  # Specify the other units that are required for this test.
  needs: [
    'model:plan'
    'model:stripe-card'
  ]

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
