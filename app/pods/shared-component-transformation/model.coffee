`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`

SharedComponentTransformation = Model.extend
  type: DS.attr 'string', defaultValue: 'js'
  body: DS.attr 'string', defaultValue: ''

  # Relationships
  shared_component: DS.belongsTo 'shared-component',
    inverse: null
    async: false
  shared_component_call: DS.belongsTo 'shared-component-call',
    inverse: null
    async: false

`export default SharedComponentTransformation`
