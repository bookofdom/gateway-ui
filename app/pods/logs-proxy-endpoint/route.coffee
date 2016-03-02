`import Ember from 'ember'`
`import LogsRoute from '../logs/route'`

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
