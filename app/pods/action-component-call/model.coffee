`import DS from 'ember-data'`
`import Model from 'gateway/pods/model/model'`

ActionComponentCall = Model.extend
  endpoint_name_override: DS.attr 'string'
  conditional: DS.attr 'string', defaultValue: ''
  conditional_positive: DS.attr 'boolean', defaultValue: true

  # Relationships
  remote_endpoint: DS.belongsTo 'remote-endpoint',
    async: false
    stains: true

`export default ActionComponentCall`
