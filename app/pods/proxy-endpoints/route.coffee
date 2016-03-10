`import Ember from 'ember'`


ProxyEndpointsRoute = Ember.Route.extend 
  queryParams:
    environment_id:
      refreshModel: false
    endpoint_group_id:
      refreshModel: false

  model: -> @modelFor('api').get 'proxy_endpoints'

`export default ProxyEndpointsRoute`
