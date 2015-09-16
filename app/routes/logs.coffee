`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

LogsRoute = Ember.Route.extend AuthenticatedRouteMixin,
  queryParams:
    query:
      refreshModel: true
    start:
      refreshModel: true
    end:
      refreshModel: true
    limit:
      refreshModel: true
    streaming:
      refreshModel: true

  model: (params) ->
    streaming = !!params.streaming
    delete params.streaming
    if streaming
      @createStreamingModel()
    else
      @store.findQuery 'log', params

  createStreamingModel: ->
    model = @store.createRecord 'log'
    model.enableStreaming()
    [model]

`export default LogsRoute`
