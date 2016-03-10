`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`

Registration = Model.extend
  email: DS.attr 'string'
  password: DS.attr 'string'
  password_confirmation: DS.attr 'string'
  organization: DS.attr 'string'

`export default Registration`
