`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`

PasswordReset = Model.extend
  email: DS.attr 'string'

`export default PasswordReset`
