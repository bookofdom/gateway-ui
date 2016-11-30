`import Ember from 'ember'`
`import DS from 'ember-data'`
`import Model from 'gateway/pods/model/model'`

ProxyEndpointChannel = Model.extend
  name: DS.attr 'string'

  # Relationships
  proxy_endpoint: DS.belongsTo 'proxy-endpoint', async: true
  remote_endpoint: DS.belongsTo 'remote-endpoint', async: false

  full_name: Ember.computed 'remote_endpoint', 'name', ->
    "#{@get('remote_endpoint')?.get('name')} #{@get('name')}"

`export default ProxyEndpointChannel`
