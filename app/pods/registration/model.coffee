`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`
`import t from 'gateway/helpers/i18n'`

Registration = Model.extend
  email: DS.attr 'string'
  password: DS.attr 'string'
  password_confirmation: DS.attr 'string'
  organization: DS.attr 'string'
  plan: DS.attr 'string', defaultValue: 'cloud-free'

  # Relationships
  card: DS.belongsTo 'stripe-card', async: false

  # Computed
  planType: Ember.computed 'plan', ->
    plan = @get 'plan'
    Registration.plans.findBy 'value', plan
  isBillable: Ember.computed 'planType', ->
    @get('planType.amountPerMonth') > 0

Registration.reopenClass
  plans: [
    name: t 'types.plans.cloud-free'
    description: t 'types.plans.description.cloud-free'
    value: 'cloud-free'
    amountPerMonth: 0
    amountUnit: 'usd'
  ,
    name: t 'types.plans.cloud-hosted'
    description: t 'types.plans.descriptions.cloud-hosted'
    value: 'cloud-hosted'
    amountPerMonth: 9
    amountUnit: 'usd'
  ]

`export default Registration`
