`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'registration', 'Unit | Model | registration', {
  # Specify the other units that are required for this test.
  needs: []
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model

test 'it has subscription plans', (assert) ->
  model = @subject()
  assert.ok model.constructor.plans

test 'it defaults to cloud-free plan', (assert) ->
  model = @subject()
  assert.equal model.get('plan'), 'cloud-free'
  assert.equal model.get('planType.amountPerMonth'), 0
  assert.equal model.get('planType.amountUnit'), 'usd'
