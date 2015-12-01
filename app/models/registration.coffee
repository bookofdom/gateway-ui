`import DS from 'ember-data'`
`import Model from './model'`

User = Model.extend
  name: DS.attr 'string'
  email: DS.attr 'string'
  password: DS.attr 'string'
  password_confirmation: DS.attr 'string'
  organization: DS.attr 'string'

`export default User`
