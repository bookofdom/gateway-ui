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

  disableStreaming: ->
    model = @modelFor 'logs'
    if model
      instance.disableStreaming() for instance in model

  createStreamingModel: ->
    model = @store.createRecord 'log'
    model.enableStreaming()
    [model]

  actions:
    # Will transition is triggered whenever query params on the current route
    # change, as well as when leaving the route altogether.
    willTransition: ->
      @disableStreaming()

`export default LogsRoute`
