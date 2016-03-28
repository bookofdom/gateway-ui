`import Ember from 'ember'`


EndpointGroupsRoute = Ember.Route.extend 
  model: -> @modelFor('api').get 'endpoint_groups'

`export default EndpointGroupsRoute`
