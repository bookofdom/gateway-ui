`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'stripe-card', 'Unit | Model | stripe card', {
  # Specify the other units that are required for this test.
  needs: ['service:stripe']
}

test 'it exists', (assert) ->
  model = @subject()
  assert.ok !!model

test 'it correctly detects card type', (assert) ->
  model = @subject()
  Ember.run ->
    assert.notOk model.get('cardType.slug'), 'no card type unless a valid card number is entered'
    model.set 'number', '42'
    assert.equal model.get('cardType.slug'), 'visa'
    model.set 'number', '4242424242424242'
    assert.equal model.get('cardType.slug'), 'visa'
    model.set 'number', '4242-4242-4242-4242'
    assert.equal model.get('cardType.slug'), 'visa'
    model.set 'number', '51'
    assert.equal model.get('cardType.slug'), 'mastercard'
    model.set 'number', '5123424242424242'
    assert.equal model.get('cardType.slug'), 'mastercard'
    model.set 'number', '5123-4242-4242-4242'
    assert.equal model.get('cardType.slug'), 'mastercard'
    model.set 'number', '378282246310005'
    assert.equal model.get('cardType.slug'), 'amex'
    model.set 'number', '6011000400000000'
    assert.equal model.get('cardType.slug'), 'discover'
    model.set 'number', '36148900647913'
    assert.equal model.get('cardType.slug'), 'diners'
    model.set 'number', '3528000700000000'
    assert.equal model.get('cardType.slug'), 'jcb'
