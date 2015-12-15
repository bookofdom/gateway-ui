`import DS from 'ember-data'`
`import Model from './model'`

PasswordReset = Model.extend
  email: DS.attr 'string'

`export default PasswordReset`
