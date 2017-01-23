`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'plan', 'Unit | Model | plan',
  # Specify the other units that are required for this test.
  needs: [
    'model:plan'
  ]

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model

test 'price defaults to 0', (assert) ->
  model = @subject()
  assert.equal model.get('price'), 0

test 'isBillable returns false when price is 0', (assert) ->
  model = @subject()
  assert.notOk model.get('isBillable')

test 'isBillable returns true when price is non-zero', (assert) ->
  model = @subject()
  Ember.run ->
    model.set 'price', 2000
    assert.ok model.get('isBillable')

test 'dollars returns price in dollars (since price is in cents)', (assert) ->
  model = @subject()
  assert.equal model.get('dollars'), 0
  Ember.run ->
    model.set 'price', 999
    assert.equal model.get('dollars'), 9.99
    model.set 'price', 2000
    assert.equal model.get('dollars'), 20
