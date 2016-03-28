`import Ember from 'ember'`


ProxyEndpointComponentsRoute = Ember.Route.extend 
  model: -> @modelFor('proxy-endpoint').get 'components'
  actions:
    saved: ->
      # no op (this event is for use by the new type component route)

`export default ProxyEndpointComponentsRoute`
