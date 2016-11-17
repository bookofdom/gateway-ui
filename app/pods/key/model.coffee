`import DS from 'ember-data'`
`import Model from 'gateway/pods/model/model'`

Key = Model.extend
  name: DS.attr 'string'
  key: DS.attr 'string'
  password: DS.attr 'string'

`export default Key`
