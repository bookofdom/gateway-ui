`import ApplicationAdapter from './application'`
`import config from  '../config/environment'`

ProxyEndpointSchemaAdapter = ApplicationAdapter.extend
  buildURL: (type, id, record) ->
    if record
      # models
      proxyEndpoint = record.belongsTo 'proxy_endpoint'
      # adapters
      proxyEndpointAdapter = @container.lookup 'adapter:proxy-endpoint'
      # IDs
      schemaId = record.get 'id'
      proxyEndpointId = proxyEndpoint.get 'id'
      # URLs
      proxyEndpointModelName = proxyEndpoint.constructor.modelName
      proxyEndpointUrl = proxyEndpointAdapter.buildURL proxyEndpointModelName, proxyEndpointId, proxyEndpoint
      if schemaId
        "#{proxyEndpointUrl}/schemas/#{schemaId}"
      else
        "#{proxyEndpointUrl}/schemas/"

`export default ProxyEndpointSchemaAdapter`
