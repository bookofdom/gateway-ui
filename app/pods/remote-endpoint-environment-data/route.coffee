`import Ember from 'ember'`


RemoteEndpointEnvironmentDataRoute = Ember.Route.extend 
  model: -> @modelFor('remote-endpoint').get 'environment_data'
  actions:
    saved: ->
      # no op (this action is for use by the new datum route)

`export default RemoteEndpointEnvironmentDataRoute`
