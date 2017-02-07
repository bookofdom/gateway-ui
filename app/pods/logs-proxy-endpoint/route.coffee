`import Ember from 'ember'`
`import LogsRoute from 'gateway-ui/pods/logs/route'`

LogsProxyEndpointRoute = LogsRoute.extend
  createStreamingModel: ->
    proxyEndpoint = @modelFor 'proxy-endpoint'
    model = @store.createRecord 'log'
    model.set 'proxy_endpoint', proxyEndpoint
    model.enableStreaming()
    [model]

  disableStreaming: ->
    model = @modelFor 'logs-proxy-endpoint'
    if model
      instance.disableStreaming() for instance in model

  queryStore: (params) ->
    params.proxy_endpoint = @modelFor 'proxy-endpoint'
    @store.query 'log', params

`export default LogsProxyEndpointRoute`
