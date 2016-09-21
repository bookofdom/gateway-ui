`import Ember from 'ember'`
`import LogsRoute from 'gateway/pods/logs/route'`

LogsJobRoute = LogsRoute.extend
  createStreamingModel: ->
    job = @modelFor 'job'
    model = @store.createRecord 'log'
    model.set 'job', job
    model.enableStreaming()
    [model]

  queryStore: (params) ->
    params.job = @modelFor 'job'
    @store.query 'log', params

`export default LogsJobRoute`
