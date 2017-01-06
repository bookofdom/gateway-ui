`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`
`import t from 'gateway-ui/helpers/i18n'`

Account = Model.extend
  name: DS.attr 'string'
  stripe_token: DS.attr 'string'

  # Relationships
  card: DS.belongsTo 'stripe-card',
    async: false
    stains: true
    embeddedModel: true
  plan: DS.belongsTo 'plan',
    async: false
    stains: true

`export default Account`
