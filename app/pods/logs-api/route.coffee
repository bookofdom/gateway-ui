`import Ember from 'ember'`
`import LogsRoute from 'gateway-ui/pods/logs/route'`

LogsApiRoute = LogsRoute.extend
  createStreamingModel: ->
    api = @modelFor 'api'
    model = @store.createRecord 'log'
    model.set 'api', api
    model.enableStreaming()
    [model]

  disableStreaming: ->
    model = @modelFor 'logs-api'
    if model
      instance.disableStreaming() for instance in model

  queryStore: (params) ->
    params.api = @modelFor 'api'
    @store.query 'log', params

`export default LogsApiRoute`
