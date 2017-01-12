`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`
`import t from 'gateway-ui/helpers/i18n'`

Registration = Model.extend
  email: DS.attr 'string'
  password: DS.attr 'string'
  password_confirmation: DS.attr 'string'
  organization: DS.attr 'string'
  stripe_token: DS.attr 'string'

  # Relationships
  plan: DS.belongsTo 'plan', async: false

`export default Registration`
