`import Ember from 'ember'`


ProxyEndpointRoutesRoute = Ember.Route.extend 
  model: -> @modelFor('proxy-endpoint').get 'routes'

`export default ProxyEndpointRoutesRoute`
