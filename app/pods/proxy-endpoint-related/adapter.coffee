`import ApplicationAdapter from 'gateway-ui/pods/application/adapter'`
`import config from  'gateway-ui/config/environment'`

ProxyEndpointRelatedAdapter = ApplicationAdapter.extend
  pathForType: (type) ->
    @_super type.replace(/^proxy-endpoint-/, '')
  buildURL: (type, id, snapshot) ->
    if snapshot
      # snapshots
      proxyEndpointSnapshot = snapshot.belongsTo 'proxy_endpoint'
      # adapters
      proxyEndpointAdapter = Ember.getOwner(@).lookup 'adapter:proxy-endpoint'
      # IDs
      snapshotId = snapshot.id
      proxyEndpointId = proxyEndpointSnapshot.id
      # URLs
      proxyEndpointModelName = proxyEndpointSnapshot.modelName
      proxyEndpointUrl = proxyEndpointAdapter.buildURL proxyEndpointModelName, proxyEndpointId, proxyEndpointSnapshot
      if snapshotId
        url = "#{proxyEndpointUrl}/#{@pathForType(type)}/#{snapshotId}"
      else
        url = "#{proxyEndpointUrl}/#{@pathForType(type)}"
      @cleanURL url

`export default ProxyEndpointRelatedAdapter`
