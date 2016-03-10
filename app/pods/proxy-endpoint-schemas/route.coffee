`import Ember from 'ember'`


ProxyEndpointSchemasRoute = Ember.Route.extend 
  model: -> @modelFor('proxy-endpoint').get 'schemas'
  actions:
    saved: ->
      # no op (this event is for use by the new type schema route)

`export default ProxyEndpointSchemasRoute`
