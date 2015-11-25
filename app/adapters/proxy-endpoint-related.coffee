`import ApplicationAdapter from './application'`
`import config from  '../config/environment'`

ProxyEndpointRelatedAdapter = ApplicationAdapter.extend
  recordPath: null
  buildURL: (type, id, record) ->
    if record
      # models
      proxyEndpoint = record.belongsTo 'proxy_endpoint'
      # adapters
      proxyEndpointAdapter = @container.lookup 'adapter:proxy-endpoint'
      # IDs
      recordId = record.get 'id'
      proxyEndpointId = proxyEndpoint.get 'id'
      # URLs
      proxyEndpointModelName = proxyEndpoint.constructor.modelName
      proxyEndpointUrl = proxyEndpointAdapter.buildURL proxyEndpointModelName, proxyEndpointId, proxyEndpoint
      if recordId
        "#{proxyEndpointUrl}/#{@recordPath}/#{recordId}"
      else
        "#{proxyEndpointUrl}/#{@recordPath}"

`export default ProxyEndpointRelatedAdapter`
