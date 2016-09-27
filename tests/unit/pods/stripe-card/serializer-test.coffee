`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'stripe-card', 'Unit | Serializer | stripe card', {
  # Specify the other units that are required for this test.
  needs: [
    'service:stripe'
    'serializer:stripe-card'
  ]
}

test 'it serializes', (assert) ->
  model = @subject()
  serialized = model.serialize()
  assert.ok serialized

test 'it reports an error for invalid credit card number', (assert) ->
  model = @subject()
  Ember.run ->
    model.set 'number', '1234'
    model.set 'exp_month', '01'
    model.set 'exp_year', '2050'
    model.set 'cvc', '123'
    serialized = model.serialize()
    assert.ok serialized.validationError
    assert.equal serialized.validationError.field, 'number'

test 'it reports an error for invalid credit card expiry', (assert) ->
  model = @subject()
  Ember.run ->
    model.set 'number', '378282246310005'
    model.set 'exp_month', '01'
    model.set 'exp_year', '1999'
    model.set 'cvc', '123'
    serialized = model.serialize()
    assert.ok serialized.validationError
    assert.equal serialized.validationError.field, 'exp_year'

test 'it reports an error for invalid credit card CVC', (assert) ->
  model = @subject()
  Ember.run ->
    model.set 'number', '378282246310005'
    model.set 'exp_month', '01'
    model.set 'exp_year', '2050'
    model.set 'cvc', ''
    serialized = model.serialize()
    assert.ok serialized.validationError
    assert.equal serialized.validationError.field, 'cvc'
