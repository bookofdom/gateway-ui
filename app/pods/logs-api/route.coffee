`import Ember from 'ember'`
`import LogsRoute from 'gateway/pods/logs/route'`

LogsApiRoute = LogsRoute.extend
  createStreamingModel: ->
    api = @modelFor 'api'
    model = @store.createRecord 'log'
    model.set 'api', api
    model.enableStreaming()
    [model]

  queryStore: (params) ->
    params.api = @modelFor 'api'
    @store.query 'log', params

`export default LogsApiRoute`
