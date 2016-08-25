`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`

JobComponentCall = Model.extend
  endpoint_name_override: DS.attr 'string'
  conditional: DS.attr 'string', defaultValue: ''
  conditional_positive: DS.attr 'boolean', defaultValue: true

  # Relationships
  remote_endpoint: DS.belongsTo 'remote-endpoint',
    async: false
    stains: true
  before: DS.hasMany 'job-component-transformation', async: false
  after: DS.hasMany 'job-component-transformation', async: false
  proxy_endpoint_component: DS.belongsTo 'job-component',
    async: false

`export default JobComponentCall`
