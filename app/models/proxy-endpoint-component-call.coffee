`import DS from 'ember-data'`
`import Model from './model'`

ProxyEndpointComponentCall = Model.extend
  endpoint_name_override: DS.attr 'string'
  conditional: DS.attr 'string', defaultValue: ''
  conditional_positive: DS.attr 'boolean', defaultValue: true

  # Relationships
  remote_endpoint: DS.belongsTo 'remote-endpoint',
    async: false
    stains: true
  before: DS.hasMany 'proxy-endpoint-component-transformation', async: false
  after: DS.hasMany 'proxy-endpoint-component-transformation', async: false
  # It's necessary to access the parent component from a call.  However, a call
  # has multiple inverses.  In order to satisfy Ember, we need multiple
  # relationships to component with explicit inverses.  In practice, only one
  # will be set at a time.
  proxy_endpoint_component_parent_1: DS.belongsTo 'proxy-endpoint-component',
    inverse: 'call'
    async: false
  proxy_endpoint_component_parent_2: DS.belongsTo 'proxy-endpoint-component',
    inverse: 'calls'
    async: false
  # Computed relationship to parent component.  Returns the currently active
  # parent component.  See above.
  proxy_endpoint_component: Ember.computed 'proxy_endpoint_component_parent_1', 'proxy_endpoint_component_parent_2', ->
    @get('proxy_endpoint_component_parent_1') or
      @get('proxy_endpoint_component_parent_2')

`export default ProxyEndpointComponentCall`
