`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`

Account = Model.extend
  name: DS.attr 'string'
  stripe_token: DS.attr 'string'

  # Relationships
  plan: DS.belongsTo 'plan',
    async: false
    stains: true

`export default Account`
