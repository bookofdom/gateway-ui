`import DS from 'ember-data'`
`import Model from 'gateway/pods/model/model'`

RegistrationActivation = Model.extend
  token: DS.attr 'string'

`export default RegistrationActivation`
