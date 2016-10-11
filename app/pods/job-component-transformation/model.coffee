`import DS from 'ember-data'`
`import Model from 'gateway/pods/model/model'`

JobComponentTransformation = Model.extend
  type: DS.attr 'string', defaultValue: 'js'
  body: DS.attr 'string', defaultValue: ''

  # Relationships
  proxy_endpoint_component: DS.belongsTo 'job-component',
    inverse: null
    async: false
  proxy_endpoint_component_call: DS.belongsTo 'job-component-call',
    inverse: null
    async: false

`export default JobComponentTransformation`
