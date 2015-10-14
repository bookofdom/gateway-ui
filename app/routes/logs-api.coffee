`import Ember from 'ember'`
`import LogsRoute from './logs'`

LogsApiRoute = LogsRoute.extend
  createStreamingModel: ->
    api = @modelFor 'api'
    model = @store.createRecord 'log'
    model.set 'api', api
    model.enableStreaming()
    [model]

  queryStore: (params) ->
    params.api = @modelFor 'api'
    @store.findQuery 'log', params

`export default LogsApiRoute`
