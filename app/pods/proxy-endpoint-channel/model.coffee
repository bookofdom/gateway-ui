`import Ember from 'ember'`
`import DS from 'ember-data'`
`import Model from 'gateway/pods/model/model'`

ProxyEndpointChannel = Model.extend
  name: DS.attr 'string'

  # Relationships
  proxy_endpoint: DS.belongsTo 'proxy-endpoint', async: true
  remote_endpoint: DS.belongsTo 'remote-endpoint', async: false

`export default ProxyEndpointChannel`
