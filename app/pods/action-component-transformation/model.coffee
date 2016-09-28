`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`

ActionComponentTransformation = Model.extend
  type: DS.attr 'string', defaultValue: 'js'
  body: DS.attr 'string', defaultValue: ''

`export default ActionComponentTransformation`
