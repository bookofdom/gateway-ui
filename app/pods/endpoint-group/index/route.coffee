`import Ember from 'ember'`


EndpointGroupIndexRoute = Ember.Route.extend 
  afterModel: -> @transitionTo 'endpoint-group.edit'

`export default EndpointGroupIndexRoute`
