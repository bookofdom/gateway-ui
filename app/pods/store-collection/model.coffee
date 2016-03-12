`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`

StoreCollection = Model.extend
  name: DS.attr 'string'

`export default StoreCollection`
