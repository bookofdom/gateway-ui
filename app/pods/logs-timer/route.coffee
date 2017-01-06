`import Ember from 'ember'`
`import LogsRoute from 'gateway-ui/pods/logs/route'`

LogsTimerRoute = LogsRoute.extend
  createStreamingModel: ->
    timer = @modelFor 'timer'
    model = @store.createRecord 'log'
    model.set 'timer', timer
    model.enableStreaming()
    [model]

  queryStore: (params) ->
    params.timer = @modelFor 'timer'
    @store.query 'log', params

`export default LogsTimerRoute`
