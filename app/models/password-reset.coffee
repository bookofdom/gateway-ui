`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`

PasswordReset = Model.extend
  email: DS.attr 'string'

`export default PasswordReset`
