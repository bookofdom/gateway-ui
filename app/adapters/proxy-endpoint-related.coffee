`import ApplicationAdapter from './application'`
`import config from  '../config/environment'`

ProxyEndpointRelatedAdapter = ApplicationAdapter.extend
  pathForType: (type) ->
    @_super type.replace(/^proxy-endpoint-/, '')
  buildURL: (type, id, snapshot) ->
    if record
      # snapshots
      proxyEndpoint = snapshot.belongsTo 'proxy_endpoint'
      # adapters
      proxyEndpointAdapter = @container.lookup 'adapter:proxy-endpoint'
      # IDs
      recordId = record.get 'id'
      proxyEndpointId = proxyEndpoint.get 'id'
      # URLs
      proxyEndpointModelName = proxyEndpoint.constructor.modelName
      proxyEndpointUrl = proxyEndpointAdapter.buildURL proxyEndpointModelName, proxyEndpointId, proxyEndpoint
      if recordId
        url = "#{proxyEndpointUrl}/#{@pathForType(type)}/#{recordId}"
      else
        url = "#{proxyEndpointUrl}/#{@pathForType(type)}"
      @cleanURL url

`export default ProxyEndpointRelatedAdapter`
