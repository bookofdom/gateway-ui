`import Ember from 'ember'`


ProxyEndpointTestEditRoute = Ember.Route.extend 
  actions:
    didTransition: ->
      @controller.reset()
      true

`export default ProxyEndpointTestEditRoute`
