`import DS from 'ember-data'`
`import Model from 'gateway/pods/model/model'`
`import t from 'gateway/helpers/i18n'`

StripeCard = Model.extend
  number: DS.attr 'string', defaultValue: ''
  cvc: DS.attr 'string', defaultValue: ''
  exp_month: DS.attr 'string', defaultValue: ''
  exp_year: DS.attr 'string', defaultValue: ''
  address_zip: DS.attr 'string', defaultValue: ''

  # Computed
  cardType: Ember.computed 'number', ->
    number = @get 'number'
    if number
      cardType = Stripe.card.cardType number
      StripeCard.cardTypes.findBy 'name', cardType

StripeCard.reopenClass
  cardTypes: [
    name: 'Visa'
    slug: 'visa'
  ,
    name: 'MasterCard'
    slug: 'mastercard'
  ,
    name: 'American Express'
    slug: 'amex'
  ,
    name: 'Discover'
    slug: 'discover'
  ,
    name: 'Diners Club'
    slug: 'diners'
  ,
    name: 'JCB'
    slug: 'jcb'
  ]

`export default StripeCard`
