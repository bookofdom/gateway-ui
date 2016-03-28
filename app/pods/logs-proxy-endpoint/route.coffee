`import Ember from 'ember'`
`import LogsRoute from 'gateway/pods/logs/route'`

LogsProxyEndpointRoute = LogsRoute.extend
  createStreamingModel: ->
    proxyEndpoint = @modelFor 'proxy-endpoint'
    model = @store.createRecord 'log'
    model.set 'proxy_endpoint', proxyEndpoint
    model.enableStreaming()
    [model]

  queryStore: (params) ->
    params.proxy_endpoint = @modelFor 'proxy-endpoint'
    @store.query 'log', params

`export default LogsProxyEndpointRoute`
