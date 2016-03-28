`import Ember from 'ember'`


ProxyEndpointTestsRoute = Ember.Route.extend 
  model: -> @modelFor('proxy-endpoint').get 'tests'
  actions:
    saved: ->
      # no op (this event is for use by the new type component route)

`export default ProxyEndpointTestsRoute`
