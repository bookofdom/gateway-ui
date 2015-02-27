`import DS from 'ember-data'`
`import Model from './model'`

ProxyEndpointComponentCall = Model.extend
  endpoint_name_override: DS.attr 'string'
  conditional: DS.attr 'string', defaultValue: ''
  conditional_positive: DS.attr 'boolean', defaultValue: true
  remote_endpoint: DS.belongsTo 'remote-endpoint', async: true
  proxy_endpoint_component: DS.belongsTo 'proxy-endpoint-component'
  remoteEndpointDirty: Ember.computed 'remote_endpoint.@each', ->
    original = @get('_data.remote_endpoint.id') or null
    current = @get('remote_endpoint.id') or null
    original != current
  relationshipsDirty: Ember.computed 'remoteEndpointDirty', ->
    @get('remoteEndpointDirty')
  relationshipsDirtyChange: Ember.observer 'relationshipsDirty', ->
    @send 'becomeDirty' if @get 'relationshipsDirty'
  onInit: Ember.on 'init', ->
    Ember.run.once => @get 'relationshipsDirty'

`export default ProxyEndpointComponentCall`
