`import Ember from 'ember'`


RemoteEndpointsRoute = Ember.Route.extend
  queryParams:
    type:
      refreshModel: false

  model: -> @modelFor('api').get 'remote_endpoints'

  actions:
    saved: -> # no op

`export default RemoteEndpointsRoute`
