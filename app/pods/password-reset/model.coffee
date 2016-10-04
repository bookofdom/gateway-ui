`import DS from 'ember-data'`
`import Model from 'gateway/pods/model/model'`

PasswordReset = Model.extend
  email: DS.attr 'string'

`export default PasswordReset`
