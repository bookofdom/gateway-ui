`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`
`import t from 'gateway/helpers/i18n'`

Registration = Model.extend
  email: DS.attr 'string'
  password: DS.attr 'string'
  password_confirmation: DS.attr 'string'
  organization: DS.attr 'string'

  plan: DS.attr 'string', defaultValue: 'cloud-free'
  cc_number: DS.attr 'string'
  cc_cvc: DS.attr 'string'
  cc_exp_month: DS.attr 'string'
  cc_exp_year: DS.attr 'string'
  cc_billing_postal_code: DS.attr 'string'

  # Computed
  cardData: Ember.computed 'cc_number', 'cc_cvc', 'cc_exp_month', 'cc_exp_year', 'cc_billing_postal_code', ->
    number: @get 'cc_number'
    cvc: @get 'cc_cvc'
    exp_month: @get 'cc_exp_month'
    exp_year: @get 'cc_exp_year'
    address_zip: @get 'cc_billing_postal_code'
  cardType: Ember.computed 'cc_number', ->
    cardData = @get 'cardData'
    if cardData.number
      cardType = Stripe.card.cardType cardData.number
      Registration.cardTypes.findBy 'name', cardType
  planType: Ember.computed 'plan', ->
    plan = @get 'plan'
    Registration.plans.findBy 'value', plan
  isBillable: Ember.computed 'planType', ->
    @get('planType.amountPerMonth') > 0

Registration.reopenClass
  plans: [
    name: t 'types.registration.plans.cloud-free'
    value: 'cloud-free'
    amountPerMonth: 0
    amountUnit: 'usd'
  ,
    name: t 'types.registration.plans.cloud-hosted'
    value: 'cloud-hosted'
    amountPerMonth: 9
    amountUnit: 'usd'
  ]
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
    slug: 'diners-club'
  ,
    name: 'JCB'
    slug: 'jcb'
  ]

`export default Registration`
