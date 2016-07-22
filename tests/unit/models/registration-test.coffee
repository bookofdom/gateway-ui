`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'registration', 'Unit | Model | registration', {
  # Specify the other units that are required for this test.
  needs: [
    'service:stripe'
    'model:stripe-card'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  assert.ok !!model

test 'it has subscription plans', (assert) ->
  model = @subject()
  assert.ok model.constructor.plans

test 'it defaults to cloud-free plan', (assert) ->
  model = @subject()
  assert.equal model.get('plan'), 'cloud-free'

test 'planType.amountPerMonth depends on plan', (assert) ->
  model = @subject()
  Ember.run ->
    assert.equal model.get('plan'), 'cloud-free'
    assert.equal model.get('planType.amountPerMonth'), 0
    model.set 'plan', 'cloud-hosted'
    assert.equal model.get('plan'), 'cloud-hosted'
    assert.equal model.get('planType.amountPerMonth'), 9

test 'isBillable returns `true` for non-zero plan amounts, otherwise `false`', (assert) ->
  model = @subject()
  Ember.run ->
    assert.equal model.get('planType.amountPerMonth'), 0
    assert.equal model.get('isBillable'), false
    model.set 'plan', 'cloud-hosted'
    assert.equal model.get('planType.amountPerMonth'), 9
    assert.equal model.get('isBillable'), true
