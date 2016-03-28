`import Ember from 'ember'`


RemoteEndpointEnvironmentDataNewRoute = Ember.Route.extend 
  actions:
    saved: ->
      model = @modelFor('remote-endpoint')
      # transition up and then down because :(
      @transitionTo('remote-endpoints').then =>
        @transitionTo 'remote-endpoint.edit', model

`export default RemoteEndpointEnvironmentDataNewRoute`
