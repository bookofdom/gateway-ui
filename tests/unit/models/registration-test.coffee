`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'registration', 'Unit | Model | registration', {
  # Specify the other units that are required for this test.
  needs: ['service:stripe']
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

test 'it correctly detects card type', (assert) ->
  model = @subject()
  Ember.run ->
    assert.notOk model.get('cardType.slug'), 'no card type unless a valid card number is entered'
    model.set 'cc_number', '4242-4242-4242-4242'
    assert.equal model.get('cardType.slug'), 'visa'
    model.set 'cc_number', '5123-4242-4242-4242'
    assert.equal model.get('cardType.slug'), 'mastercard'
    model.set 'cc_number', '378282246310005'
    assert.equal model.get('cardType.slug'), 'amex'
    model.set 'cc_number', '6011000400000000'
    assert.equal model.get('cardType.slug'), 'discover'
    model.set 'cc_number', '36148900647913'
    assert.equal model.get('cardType.slug'), 'diners'
    model.set 'cc_number', '3528000700000000'
    assert.equal model.get('cardType.slug'), 'jcb'
