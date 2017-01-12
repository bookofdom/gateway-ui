`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

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
    if streaming
      @createStreamingModel()
    else
      delete params.streaming
      cleanedParams = {}
      for key, value of params
        cleanedParams[key] = value if !Ember.isEmpty value
      @queryStore cleanedParams

  disableStreaming: ->
    model = @modelFor 'logs'
    if model
      instance.disableStreaming() for instance in model

  createStreamingModel: ->
    model = @store.createRecord 'log'
    model.enableStreaming()
    [model]

  queryStore: (params) ->
    @store.query 'log', params

  actions:
    # Will transition is triggered whenever query params on the current route
    # change, as well as when leaving the route altogether.
    willTransition: ->
      @disableStreaming()
    'reconnect-streaming': ->
      @refresh()

`export default LogsRoute`
