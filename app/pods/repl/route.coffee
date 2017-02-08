`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

ReplRoute = Ember.Route.extend AuthenticatedRouteMixin,
  queryParams:
    environment:
      refreshModel: true

  model: (params) ->
    @createStreamingModel params

  disableStreaming: ->
    model = @modelFor 'repl'
    model.disableStreaming()

  createStreamingModel: (params) ->
    model = @store.createRecord 'repl-session'
    environment = @modelFor('api').get('environments').findBy 'id', params.environment
    environment ?= @modelFor('api').get 'environments.firstObject'
    model.set 'environment', environment
    model.enableStreaming()
    model

  actions:
    # Will transition is triggered when leaving the route altogether.
    willTransition: ->
      @disableStreaming()
    'reconnect-streaming': ->
      @refresh()
    changeEnvironment: (name) ->
      environment = @modelFor('api').get('environments').find (environment) ->
        environment.get('name').toLowerCase() == name.toLowerCase()
      if environment
        @transitionTo 'repl', queryParams:
          environment: environment.id
      else
        @modelFor('repl').print
          type: 'error'
          data: "Environment not found:  #{name}"

`export default ReplRoute`
