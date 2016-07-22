`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'registration', 'Unit | Serializer | registration', {
  # Specify the other units that are required for this test.
  needs: [
    'service:stripe'
    'serializer:registration'
  ]
}

test 'it serializes', (assert) ->
  model = @subject()
  serialized = model.serialize()
  assert.ok serialized

test 'it does not serialize credit card fields', (assert) ->
  model = @subject()
  Ember.run ->
    model.set 'cc_number', '1234'
    model.set 'cc_exp_month', '01'
    model.set 'cc_exp_year', '0001'
    model.set 'cc_cvc', '123'
    model.set 'cc_address_zip', '01234'
    serialized = model.serialize()
    assert.notOk serialized.cc_number
    assert.notOk serialized.cc_exp_month
    assert.notOk serialized.cc_exp_year
    assert.notOk serialized.cc_cvc
    assert.notOk serialized.cc_address_zip

test 'it reports an error for invalid credit card number', (assert) ->
  model = @subject()
  Ember.run ->
    model.set 'plan', 'cloud-hosted'
    model.set 'cc_number', '1234'
    model.set 'cc_exp_month', '01'
    model.set 'cc_exp_year', '2050'
    model.set 'cc_cvc', '123'
    serialized = model.serialize()
    assert.ok serialized.ccValidationError
    assert.equal serialized.ccValidationError.field, 'cc_number'

test 'it reports an error for invalid credit card expiry', (assert) ->
  model = @subject()
  Ember.run ->
    model.set 'plan', 'cloud-hosted'
    model.set 'cc_number', '378282246310005'
    model.set 'cc_exp_month', '01'
    model.set 'cc_exp_year', '1999'
    model.set 'cc_cvc', '123'
    serialized = model.serialize()
    assert.ok serialized.ccValidationError
    assert.equal serialized.ccValidationError.field, 'cc_exp_year'

test 'it reports an error for invalid credit card CVC', (assert) ->
  model = @subject()
  Ember.run ->
    model.set 'plan', 'cloud-hosted'
    model.set 'cc_number', '378282246310005'
    model.set 'cc_exp_month', '01'
    model.set 'cc_exp_year', '2050'
    model.set 'cc_cvc', ''
    serialized = model.serialize()
    assert.ok serialized.ccValidationError
    assert.equal serialized.ccValidationError.field, 'cc_cvc'
