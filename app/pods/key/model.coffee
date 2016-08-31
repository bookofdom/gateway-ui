`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`

Key = Model.extend
  name: DS.attr 'string'
  key: DS.attr 'string'

`export default Key`
