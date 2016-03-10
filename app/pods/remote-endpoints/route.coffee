`import Ember from 'ember'`


RemoteEndpointsRoute = Ember.Route.extend 
  queryParams:
    type:
      refreshModel: false

  model: -> @modelFor('api').get 'remote_endpoints'

`export default RemoteEndpointsRoute`
