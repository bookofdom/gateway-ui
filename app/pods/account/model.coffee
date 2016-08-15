`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`
`import Registration from 'gateway/pods/registration/model'`
`import t from 'gateway/helpers/i18n'`

Account = Model.extend
  name: DS.attr 'string'
  card_invalid: DS.attr 'boolean', defaultValue: false

  # Relationships
  card: DS.belongsTo 'stripe-card',
    async: false
    stains: true
    embeddedModel: true
  plan: DS.belongsTo 'plan', async: false

`export default Account`
