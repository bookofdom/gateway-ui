`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'registration', 'Unit | Serializer | registration', {
  # Specify the other units that are required for this test.
  needs: ['serializer:registration']
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
    model.set 'cc_billing_postal_code', '01234'
    serialized = model.serialize()
    assert.notOk serialized.cc_number
    assert.notOk serialized.cc_exp_month
    assert.notOk serialized.cc_exp_year
    assert.notOk serialized.cc_cvc
    assert.notOk serialized.cc_billing_postal_code
