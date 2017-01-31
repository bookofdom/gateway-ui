`import Ember from 'ember'`

ProxyEndpointsRoute = Ember.Route.extend
  model: -> @modelFor('api').get 'proxy_endpoints'

  actions:
    saved: (model) ->
      @transitionTo 'proxy-endpoint', model

`export default ProxyEndpointsRoute`
