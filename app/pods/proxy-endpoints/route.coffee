`import Ember from 'ember'`

ProxyEndpointsRoute = Ember.Route.extend
  queryParams:
    environment_id:
      refreshModel: false
    endpoint_group_id:
      refreshModel: false

  model: -> @modelFor('api').get 'proxy_endpoints'

  actions:
    saved: (model) ->
      @transitionTo 'proxy-endpoint', model

`export default ProxyEndpointsRoute`
