`import DS from 'ember-data'`
`import ActionComponentTransformation from 'gateway/pods/action-component-transformation/model'`

JobComponentTransformation = ActionComponentTransformation.extend
  # Relationships
  proxy_endpoint_component: DS.belongsTo 'job-component',
    inverse: null
    async: false
  proxy_endpoint_component_call: DS.belongsTo 'job-component-call',
    inverse: null
    async: false

`export default JobComponentTransformation`
