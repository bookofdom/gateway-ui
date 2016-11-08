`import DS from 'ember-data'`
`import Model from 'gateway/pods/model/model'`

RegistrationConfirmation = Model.extend
  token: DS.attr 'string'

`export default RegistrationConfirmation`
