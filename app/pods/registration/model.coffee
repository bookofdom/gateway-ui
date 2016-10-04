`import DS from 'ember-data'`
`import Model from 'gateway/pods/model/model'`
`import t from 'gateway/helpers/i18n'`

Registration = Model.extend
  email: DS.attr 'string'
  password: DS.attr 'string'
  password_confirmation: DS.attr 'string'
  organization: DS.attr 'string'

  # Relationships
  card: DS.belongsTo 'stripe-card', async: false
  plan: DS.belongsTo 'plan', async: false

`export default Registration`
