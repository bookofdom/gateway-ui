`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`
`import Registration from 'gateway/pods/registration/model'`
`import t from 'gateway/helpers/i18n'`

Account = Model.extend
  name: DS.attr 'string'

  # Relationships
  card: DS.belongsTo 'stripe-card',
    async: false
    stains: true
    embeddedModel: true
  plan: DS.belongsTo 'plan',
    async: false
    stains: true
  keys: DS.hasMany 'account-key', async: true

`export default Account`
