`import DS from 'ember-data'`
`import ActionComponentCall from 'gateway/pods/action-component-call/model'`

JobComponentCall = ActionComponentCall.extend
  # Relationships
  before: DS.hasMany 'job-component-transformation', async: false
  after: DS.hasMany 'job-component-transformation', async: false
  proxy_endpoint_component: DS.belongsTo 'job-component',
    async: false

`export default JobComponentCall`
