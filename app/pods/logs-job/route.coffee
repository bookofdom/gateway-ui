`import Ember from 'ember'`
`import LogsRoute from 'gateway-ui/pods/logs/route'`

LogsJobRoute = LogsRoute.extend
  createStreamingModel: ->
    job = @modelFor 'job'
    model = @store.createRecord 'log'
    model.set 'job', job
    model.enableStreaming()
    [model]

  disableStreaming: ->
    model = @modelFor 'logs-job'
    if model
      instance.disableStreaming() for instance in model

  queryStore: (params) ->
    params.job = @modelFor 'job'
    @store.query 'log', params

`export default LogsJobRoute`
