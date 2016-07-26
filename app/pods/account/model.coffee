`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`
`import Registration from 'gateway/pods/registration/model'`
`import t from 'gateway/helpers/i18n'`

Account = Model.extend
  name: DS.attr 'string'
  plan: DS.attr 'string', defaultValue: 'cloud-free'

  # Relationships
  card: DS.belongsTo 'stripe-card',
    async: false
    stains: true
    embeddedModel: true

  # Computed
  planType: Ember.computed 'plan', ->
    plan = @get 'plan'
    Registration.plans.findBy 'value', plan
  isBillable: Ember.computed 'planType', ->
    @get('planType.amountPerMonth') > 0

`export default Account`
