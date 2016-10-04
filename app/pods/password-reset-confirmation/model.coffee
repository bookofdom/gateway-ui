`import DS from 'ember-data'`
`import Model from 'gateway/pods/model/model'`

PasswordResetConfirmation = Model.extend
  token: DS.attr 'string'
  new_password: DS.attr 'string'

`export default PasswordResetConfirmation`
