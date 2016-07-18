`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`
`import t from 'gateway/helpers/i18n'`

Registration = Model.extend
  email: DS.attr 'string'
  password: DS.attr 'string'
  password_confirmation: DS.attr 'string'
  organization: DS.attr 'string'

  plan: DS.attr 'string', defaultValue: 'cloud-free'
  cc_number: DS.attr 'number'
  cc_cvc: DS.attr 'number'
  cc_exp_month: DS.attr 'number'
  cc_exp_year: DS.attr 'number'

  # Computed
  cardType: Ember.computed 'cc_number', ->
    ccNumber = @get 'cc_number'
    if ccNumber
      cardType = Stripe.card.cardType ccNumber
      Registration.cardTypes.findBy 'name', cardType
  planType: Ember.computed 'plan', ->
    plan = @get 'plan'
    Registration.plans.findBy 'value', plan

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
