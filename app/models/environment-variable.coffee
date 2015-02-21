`import DS from 'ember-data'`
`import Model from './model'`

EnvironmentVariable = Model.extend
  name: DS.attr 'string'
  value: DS.attr 'string'

`export default EnvironmentVariable`
